//
//  ErrorAlertViewModifier.swift
//  
//
//  Created by JSilver on 2023/03/21.
//

import SwiftUI
import Combine
import JSToast
import Logger

final class AlertQueue: ObservableObject {
    // MARK: - Property
    private static var queues: [UIWindowScene?: AlertQueue] = [:]
    static func queue(scene: UIWindowScene?) -> AlertQueue {
        guard let queue = queues[scene] else {
            let queue = AlertQueue()
            queues[scene] = queue
            return queue
        }
        
        return queue
    }
    
    @Published
    private(set) var item: (id: Namespace.ID, data: Any)?
    
    var isEmpty: Bool { queue.isEmpty }
    
    private var queue: [(Namespace.ID, Any)] = []
    private var deferredRemove: Bool = false
    
    // MARK: - Initializer
    private init() { }
    
    // MARK: - Public
    func insert(_ data: Any, for id: Namespace.ID) {
        queue.append((id, data))
    }
    
    func remove() {
        guard !queue.isEmpty else { return }
        queue.removeLast()
    }
    
    func reset() {
        item = nil
    }
    
    func check() {
        item = queue.last
    }
    
    // MARK: - Private
}

struct AlertViewModifier<Data, Alert: View>: ViewModifier {
    // MARK: - Property
    private let publisher: AnyPublisher<Data, Never>
    private let duration: TimeInterval?
    private let alert: (Data, _ dismiss: @escaping ((() -> Void)?) -> Void) -> Alert
    
    @Namespace
    private var id: Namespace.ID
    @State
    private var isShow: Bool = false
    
    // MARK: - Initializer
    init<P: Publisher>(
        _ publisher: P,
        duration: TimeInterval? = nil,
        @ViewBuilder alert: @escaping (Data, _ dismiss: @escaping ((() -> Void)?) -> Void) -> Alert
    ) where P.Output == Data, P.Failure == Never {
        self.publisher = publisher.eraseToAnyPublisher()
        self.duration = duration
        self.alert = alert
    }
    
    // MARK: - Lifecycle
    func body(content: Content) -> some View {
        content.background(
            ToastContainer { layer in
                Group {
                    if let window = layer.view?.window,
                       let scene = window.windowScene {
                        let queue = AlertQueue.queue(scene: scene)
                        
                        GeometryReader { reader in
                            let frame = reader.frame(in: .global)
                            
                            Color.clear
                                .toast(
                                    $isShow,
                                    duration: duration,
                                    layouts: [
                                        .inside(.top),
                                        .inside(.trailing),
                                        .inside(.bottom),
                                        .inside(.leading)
                                    ],
                                    showAnimation: .fadeIn(duration: 0.2),
                                    hideAnimation: .fadeOut(duration: 0.2),
                                    hidden: { _ in
                                        queue.check()
                                    }
                                ) {
                                    if let data = queue.item?.data as? Data {
                                        var completion: (() -> Void)?
                                        
                                        alert(data) {
                                            completion = $0
                                            
                                            queue.remove()
                                            queue.reset()
                                        }
                                            .onDisappear {
                                                completion?()
                                            }
                                    }
                                }
                                    .offset(
                                        x: -frame.minX,
                                        y: -frame.minY
                                    )
                        }
                            .frame(
                                width: window.screen.bounds.width,
                                height: window.screen.bounds.height
                            )
                            .subscribe(queue.$item) { item in
                                guard item?.id == id else {
                                    isShow = false
                                    return
                                }
                                
                                isShow = (item?.data as? Data) != nil
                            }
                    }
                }
                    .subscribe(publisher) { data in
                        guard let scene = layer.view?.window?.windowScene else { return }
                        
                        let queue = AlertQueue.queue(scene: scene)
                        
                        Task {
                            if queue.isEmpty {
                                queue.insert(data, for: id)
                                queue.check()
                            } else {
                                queue.insert(data, for: id)
                                queue.reset()
                            }
                        }
                    }
            }
        )
    }
    
    // MARK: - Public
    
    // MARK: - Private
}

public extension View {
    func alert<
        Data,
        P: Publisher,
        Alert: View
    >(
        _ publisher: P,
        duration: TimeInterval? = nil,
        @ViewBuilder alert: @escaping (Data, _ dismiss: @escaping ((() -> Void)?) -> Void) -> Alert
    ) -> some View where P.Output == Data, P.Failure == Never {
        modifier(AlertViewModifier(
            publisher,
            duration: duration,
            alert: alert
        ))
    }
}

#if DEBUG
struct AlertViewModifier_Preview: View {
    var body: some View {
        GeometryReader { reader in
            ScrollView(.horizontal) {
                HStack {
                    ZStack {
                        Button("Show Alert") {
                            alert.send(Void())
                        }
                            .buttonStyle(.borderedProminent)
                            .fixedSize()
                            .alert(countAlert) { count, dismiss in
                                ZStack {
                                    Color.black.opacity(0.6)
                                    VStack {
                                        Text("Count Alert \(count)")
                                        Button("dismiss") {
                                            dismiss(nil)
                                        }
                                        .buttonStyle(.borderedProminent)
                                    }
                                    .background(Color.white)
                                }
                            }
                            .alert(alert) { _, dismiss in
                                ZStack {
                                    Color.black.opacity(0.6)
                                    
                                    VStack(spacing: 12) {
                                        Text("Confirm Deletion")
                                            .padding(6)
                                            .font(Font(R.Font.font(ofSize: 20, weight: .medium)))
                                            .foregroundColor(Color(uiColor: R.Color.gray01))
                                        Text("Deleted data cannot be recovere.\nContinue?")
                                            .multilineTextAlignment(.center)
                                            .font(Font(R.Font.font(ofSize: 14, weight: .regular)))
                                            .foregroundColor(Color(uiColor: R.Color.gray02))
                                        HStack(spacing: 8) {
                                            Button {
                                                dismiss(nil)
                                                /* Pefrom delete action */
                                            } label: {
                                                Text("Yes, Delete")
                                                    .font(Font(R.Font.font(ofSize: 16, weight: .medium)))
                                                    .foregroundColor(Color(uiColor: R.Color.gray04))
                                                    .frame(maxWidth: .infinity)
                                            }
                                            Button {
                                                dismiss(nil)
                                            } label: {
                                                Text("No, Cancel")
                                                    .font(Font(R.Font.font(ofSize: 16, weight: .medium)))
                                                    .foregroundColor(Color(uiColor: R.Color.green01))
                                                    .frame(maxWidth: .infinity)
                                            }
                                        }
                                        .padding(.vertical, 14)
                                    }
                                    .frame(width: 247)
                                    .padding(16)
                                    .background(Color(uiColor: R.Color.white))
                                    .cornerRadius(10)
                                }
                            }
                    }
                        .frame(
                            width: reader.size.width,
                            height: reader.size.height
                        )
                    
                    Color.green
                        .frame(
                            width: reader.size.width,
                            height: reader.size.height
                        )
                }
            }
        }
    }
    
    @State
    var count = 0
    
    let alert = PassthroughSubject<Void, Never>()
    let countAlert = PassthroughSubject<Int, Never>()
}

struct AlertViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        AlertViewModifier_Preview()
    }
}
#endif
