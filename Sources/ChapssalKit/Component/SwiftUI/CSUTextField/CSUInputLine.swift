//
//  CSUInputLineTheme.swift
//
//
//  Created by JSilver on 2023/02/23.
//

import SwiftUI

public protocol CSUInputLineState {
    var textColor: UIColor { get }
    var tintColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var borderColor: UIColor { get }
}

public struct CSUInputLine: View {
    public enum State: CSUInputLineState, CaseIterable {
        case normal
        case error
        
        public var textColor: UIColor {
            guard case .error = self else { return R.Color.gray01 }
            return R.Color.red01
        }
        
        public var tintColor: UIColor {
            guard case .error = self else { return R.Color.green01 }
            return R.Color.red01
        }
        
        public var backgroundColor: UIColor {
            R.Color.white
        }
        
        public var borderColor: UIColor {
            guard case .error = self else { return R.Color.gray04 }
            return R.Color.red01
        }
    }
    
    // MARK: - View
    public var body: some View {
        CSUTextField(
            placeholder,
            text: text
        )
            .csuTextField(\.textColor, state.textColor)
            .csuTextField(\.tintColor, state.tintColor)
            .csuTextField(
                \.contentInsets,
                 .init(
                    top: 14,
                    leading: 0,
                    bottom: 14,
                    trailing: 0
                 )
            )
            .csuTextField(\.backgroundColor, state.backgroundColor)
            .csuTextField(\.cornerRadius, 0)
            .csuTextField(\.borderEdges, .bottom)
            .csuTextField(\.borderWidth, 1)
            .csuTextField(\.borderColor, state.borderColor)
    }
    
    // MARK: - Property
    public var placeholder: String
    private var text: Binding<String>
    public var state: any CSUInputLineState
    
    // MARK: - Initializer
    public init(
        _ placeholder: String = "",
        text: Binding<String>,
        state: any CSUInputLineState = CSUInputLine.State.normal
    ) {
        self.text = text
        self.placeholder = placeholder
        self.state = state
    }
    
    // MARK: - Public
    
    // MARK: - Private
}

#if DEBUG
struct CSUInputLine_Preview: View {
    @State
    var text: String = ""
    @State
    var focus: Bool = false
    
    @State
    var state: CSUInputLine.State = .normal
    @State
    var secureTextEntryMode: CSUTextField.SecureTextEntryMode = .never
    
    var body: some View {
        VStack {
            VStack {
                Picker("Secure Text Entry", selection: $secureTextEntryMode) {
                    ForEach(CSUTextField.SecureTextEntryMode.allCases, id: \.self) { state in
                        switch state {
                        case .always:
                            Text("Always")
                            
                        case .never:
                            Text("Never")
                            
                        case .whileEditing:
                            Text("While Editing")
                            
                        case .unlessEditing:
                            Text("Unless Editing")
                        }
                    }
                }
                
                Picker("State", selection: $state) {
                    ForEach(CSUInputLine.State.allCases, id: \.self) { state in
                        switch state {
                        case .normal:
                            Text("Normal")
                            
                        case .error:
                            Text("Error")
                        }
                    }
                }
            }
                .pickerStyle(.segmented)
            
            VStack {
                CSUInputLine(
                    "input",
                    text: $text,
                    state: state
                )
                    .csuTextField(\.isEditing, $focus)
                    .csuTextField(\.secureTextEntryMode, secureTextEntryMode)
                    .fixedSize(horizontal: false, vertical: true)
                
                CSUFillButton(title: "Resign First Responder") {
                    focus = false
                }
                .fixedSize(horizontal: false, vertical: true)
            }
        }
            .padding(.horizontal, 16)
    }
}

struct CSUInputLine_Previews: PreviewProvider {
    static var previews: some View {
        CSUInputLine_Preview()
            .previewLayout(.sizeThatFits)
    }
}
#endif
