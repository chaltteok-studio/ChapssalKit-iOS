//
//  ErrorAlertViewModifier.swift
//  
//
//  Created by JSilver on 2023/03/21.
//

import SwiftUI
import Combine
import JSToast

final class AlertQueue<Data>: ObservableObject {
    // MARK: - Property
    @Published
    var data: Data?
    
    private var queue: [Data] = []
    
    // MARK: - Initializer
    
    // MARK: - Public
    func insert(_ data: Data) {
        queue.insert(data, at: 0)
        self.data = data
    }
    
    func remove() {
        queue.removeFirst()
        data = queue.first
    }
    
    // MARK: - Private
}

struct AlertViewModifier<Data, Alert: View>: ViewModifier {
    // MARK: - Property
    private let publisher: AnyPublisher<Data, Never>
    private let duration: TimeInterval?
    private let alert: (Data, _ dismiss: @escaping () -> Void) -> Alert
    
    private var currentWindow: UIWindow? {
        let windowScene = UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene) }
            .first { $0.activationState == .foregroundActive }
        
        return windowScene?.keyWindow
    }
    
    @StateObject
    private var queue: AlertQueue<Data> = AlertQueue()
    @State
    private var isShow: Bool = false
    
    // MARK: - Initializer
    init<P: Publisher>(
        _ publisher: P,
        duration: TimeInterval? = nil,
        @ViewBuilder alert: @escaping (Data, _ dismiss: @escaping () -> Void) -> Alert
    ) where P.Output == Data, P.Failure == Never {
        self.publisher = publisher.eraseToAnyPublisher()
        self.duration = duration
        self.alert = alert
    }
    
    // MARK: - Lifecycle
    func body(content: Content) -> some View {
        content.background(
            GeometryReader { reader in
                let safeAreaInsets = reader.safeAreaInsets
                
                Color.clear
                    .toast(
                        $isShow,
                        duration: duration,
                        layouts: [
                            .inside(of: .top),
                            .inside(of: .trailing),
                            .inside(of: .bottom),
                            .inside(of: .leading)
                        ],
                        showAnimation: .fadeIn(duration: 0.2),
                        hideAnimation: .fadeOut(duration: 0.2),
                        hidden: { _ in
                            isShow = queue.data != nil
                        }
                    ) {
                        if let data = queue.data {
                            alert(data) {
                                isShow = false
                                queue.remove()
                            }
                        }
                    }
                        .offset(
                            x: safeAreaInsets.trailing - safeAreaInsets.leading,
                            y: safeAreaInsets.bottom - safeAreaInsets.top
                        )
            }
                .frame(
                    width: currentWindow?.bounds.width ?? 0,
                    height: currentWindow?.bounds.height ?? 0
                )
                
        )
            .subscribe(publisher) { data in
                Task {
                    let currentData = queue.data
                    isShow = currentData == nil
                    
                    queue.insert(data)
                }
            }
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
        @ViewBuilder alert: @escaping (Data, _ dismiss: @escaping () -> Void) -> Alert
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
        ZStack {
            Button("Show Alert") {
                alert.send(Void())
            }
                .buttonStyle(.borderedProminent)
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
                            dismiss()
                            /* Pefrom delete action */
                        } label: {
                            Text("Yes, Delete")
                                .font(Font(R.Font.font(ofSize: 16, weight: .medium)))
                                .foregroundColor(Color(uiColor: R.Color.gray04))
                                .frame(maxWidth: .infinity)
                        }
                        Button {
                            dismiss()
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
    
    let alert = PassthroughSubject<Void, Never>()
}

struct AlertViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        AlertViewModifier_Preview()
    }
}
#endif
