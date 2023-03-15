//
//  CSULineInputStyle.swift
//
//
//  Created by JSilver on 2023/02/23.
//

import SwiftUI

public protocol CSULineInputState {
    var textColor: UIColor { get }
    var tintColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var borderColor: UIColor { get }
}

public struct CSULineInputStyle: CSUTextFieldStyle {
    public enum State: CSULineInputState, CaseIterable {
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
    
    private struct Content: View {
        // MARK: - View
        var body: some View {
            configuration.label
                .csuTextField(\.textColor, config.$textColor(state.textColor))
                .csuTextField(\.tintColor, config.$tintColor(state.tintColor))
                .csuTextField(
                    \.contentInsets,
                     config.$contentInsets(.init(
                        top: 14,
                        leading: 0,
                        bottom: 14,
                        trailing: 0
                     )
                ))
                .csuTextField(\.backgroundColor, config.$backgroundColor(state.backgroundColor))
                .csuTextField(\.cornerRadius, config.$cornerRadius(0))
                .csuTextField(\.borderEdges, config.$borderEdges(.bottom))
                .csuTextField(\.borderWidth, config.$borderWidth(1))
                .csuTextField(\.borderColor, config.$borderColor(state.borderColor))
        }
        
        // MARK: - Property
        let configuration: CSUTextFieldStyleConfiguration
        let state: any CSULineInputState
        
        @Environment(\.isEnabled)
        var isEnabled: Bool
        
        @Environment(\.csuTextField)
        var config: CSUTextField.Configuration
        
        // MARK: - Initializer
        init(_ configuration: Configuration, state: any CSULineInputState) {
            self.configuration = configuration
            self.state = state
        }
    }
    
    public var state: any CSULineInputState
    
    public init(state: any CSULineInputState) {
        self.state = state
    }
    
    public func makeBody(_ configuration: Configuration) -> some View {
        Content(configuration, state: state)
    }
}

#if DEBUG
struct CSULineInput_Preview: View {
    @State
    var text: String = ""
    @State
    var focus: Bool = false
    
    @State
    var state: CSULineInputStyle.State = .normal
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
                    ForEach(CSULineInputStyle.State.allCases, id: \.self) { state in
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
                CSUTextField(
                    "input",
                    text: $text
                )
                    .csuTextField(\.style, .lineInput(state: state))
                    .csuTextField(\.isEditing, $focus)
                    .csuTextField(\.secureTextEntryMode, secureTextEntryMode)
                    .fixedSize(horizontal: false, vertical: true)
                
                CSUButton(title: "Resign First Responder") {
                    focus = false
                }
                    .csuButton(\.style, .fill)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
            .padding(.horizontal, 16)
    }
}

struct CSULineInput_Previews: PreviewProvider {
    static var previews: some View {
        CSULineInput_Preview()
            .previewLayout(.sizeThatFits)
    }
}
#endif
