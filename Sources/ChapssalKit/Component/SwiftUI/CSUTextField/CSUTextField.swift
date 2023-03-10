//
//  CSUTextField.swift
//  
//
//  Created by JSilver on 2023/02/21.
//

import UIKit
import SwiftUI

public struct CSUTextField: View {
    struct ConfigurationKey: EnvironmentKey {
        static var defaultValue = Configuration()
    }
    
    public struct Configuration {
        @Config
        public var tintColor: UIColor = R.Color.green01
        @Config
        public var textColor: UIColor = R.Color.gray01
        @Config
        public var placeholderColor: UIColor = R.Color.gray03
        @Config
        public var font: UIFont = R.Font.font(ofSize: 16, weight: .medium)
        @Config
        public var contentInsets: EdgeInsets = EdgeInsets(top: 14, leading: 12, bottom: 14, trailing: 12)
        
        @Config
        public var isSecureTextEntry: Binding<Bool>?
        @Config
        public var isAutocorrection: Bool = false
        @Config
        public var isSpellChecking: Bool = false
        @Config
        public var autocapitalization: UITextAutocapitalizationType = .none
        
        @Config
        public var keyboardType: UIKeyboardType = .default
        @Config
        public var returnKeyType: UIReturnKeyType = .default
        
        @Config
        public var inputAccessoryViewHeight: CGFloat = 0
        @Config
        public var inputAccessoryView: (any View)?
        
        @Config
        public var clearButtonMode: ClearButtonMode = .whileEditing
        @Config
        public var secureTextEntryMode: SecureTextEntryMode = .never
        
        @Config
        public var leftAccessories: [any View] = []
        @Config
        public var leftInterAccessoriesSpacing: CGFloat = 0
        @Config
        public var rightAccessories: [any View] = []
        @Config
        public var rightInterAccessoriesSpacing: CGFloat = 0
        
        @Config
        public var backgroundColor: UIColor = R.Color.white
        
        @Config
        public var cornerRadius: CGFloat = 8
        @Config
        public var borderEdges: Edge.Set = .all
        @Config
        public var borderColor: UIColor = R.Color.gray04
        @Config
        public var borderWidth: CGFloat = 1
        
        @Config
        public var isEditing: Binding<Bool>?
        @Config
        public var onReturn: (() -> Void)?
        
        @Config
        public var style: any CSUTextFieldStyle = .plain
    }
    
    public enum ClearButtonMode: CaseIterable {
        case never
        case whileEditing
        case unlessEditing
        case always
        
        func isHidden(text: String, isEditing: Bool) -> Bool {
            switch self {
            case .always:
                return false
                
            case .never:
                return true
                
            case .whileEditing:
                return text.isEmpty || !isEditing
                
            case .unlessEditing:
                return text.isEmpty || isEditing
            }
        }
    }

    public enum SecureTextEntryMode: CaseIterable {
        case never
        case whileEditing
        case unlessEditing
        case always
        
        func isHidden(text: String, isEditing: Bool) -> Bool {
            switch self {
            case .always:
                return false
                
            case .never:
                return true
                
            case .whileEditing:
                return text.isEmpty || !isEditing
                
            case .unlessEditing:
                return text.isEmpty || isEditing
            }
        }
    }
    
    struct Content: View {
        // MARK: - View
        var body: some View {
            let backgroundColor = Color(uiColor: config.backgroundColor)
            let borderColor = isEditing ? Color(uiColor: config.tintColor) : Color(uiColor: config.borderColor)
            
            ZStack {
                ContentView()
            }
                .frame(minHeight: 52)
                .background(backgroundColor)
                .cornerRadius(config.cornerRadius)
                .overlay(
                    EdgeBorder(
                        edges: config.borderEdges,
                        cornerRadius: config.cornerRadius
                    )
                    .stroke(
                        borderColor,
                        lineWidth: config.borderWidth
                    )
                )
        }
        
        @ViewBuilder
        private func Root(
            placeholder: String,
            text: Binding<String>
        ) -> some View {
            let backgroundColor = Color(uiColor: config.backgroundColor)
            let borderColor = isEditing ? Color(uiColor: config.tintColor) : Color(uiColor: config.borderColor)
            
            ZStack {
                ContentView()
            }
                .frame(minHeight: 52)
                .background(backgroundColor)
                .cornerRadius(config.cornerRadius)
                .overlay(
                    EdgeBorder(
                        edges: config.borderEdges,
                        cornerRadius: config.cornerRadius
                    )
                    .stroke(
                        borderColor,
                        lineWidth: config.borderWidth
                    )
                )
        }
        
        @ViewBuilder
        private func ContentView() -> some View {
            HStack(spacing: 12) {
                Accessories(
                    spacing: config.leftInterAccessoriesSpacing,
                    config.leftAccessories
                )
                    .layoutPriority(1)
                
                HStack(spacing: 0) {
                    TextField()
                    ClearButton()
                }
                
                SecureTextEntryButton()
                
                Accessories(
                    spacing: config.rightInterAccessoriesSpacing,
                    config.rightAccessories
                )
                    .layoutPriority(1)
            }
                .padding(config.contentInsets)
        }
        
        @ViewBuilder
        private func TextField() -> some View {
            ZStack(alignment: .trailing) {
                UITextFieldView(placeholder, text: $text)
                    .textColor(config.textColor)
                    .placeholderColor(config.placeholderColor)
                    .tintColor(config.tintColor)
                    .font(config.font)
                    .editing($isEditing)
                    .secureTextEntry(isSecureTextEntry)
                    .autocorrection(config.isAutocorrection)
                    .spellChecking(config.isSpellChecking)
                    .autocapitalization(config.autocapitalization)
                    .returnKeyType(config.returnKeyType)
                    .keyboardType(config.keyboardType)
                    .inputAccessoryView(
                        height: config.inputAccessoryViewHeight,
                        inputAccessoryView: config.inputAccessoryView
                    )
                    .onReturn {
                        config.onReturn?()
                    }
            }
        }
        
        @ViewBuilder
        private func ClearButton() -> some View {
            if !config.clearButtonMode.isHidden(
                text: text,
                isEditing: isEditing
            ) {
                Button {
                    text = ""
                } label: {
                    Image(uiImage: R.Icon.ic24Clear)
                        .foregroundColor(Color(uiColor: R.Color.gray04))
                }
                    .buttonStyle(.plain)
            }
        }
        
        @ViewBuilder
        private func SecureTextEntryButton() -> some View {
            let image = isSecureTextEntry ? R.Icon.ic24Vision : R.Icon.ic24Blind
            let color = isEditing ? config.tintColor : R.Color.gray04
            
            if !config.secureTextEntryMode.isHidden(
                text: text,
                isEditing: isEditing
            ) {
                Button {
                    isSecureTextEntry.toggle()
                } label: {
                    Image(uiImage: image)
                        .foregroundColor(Color(uiColor: color))
                }
                    .buttonStyle(.plain)
            }
        }
        
        @ViewBuilder
        private func Accessories(
            spacing: CGFloat,
            _ accessories: [any View]
        ) -> some View {
            let tintColor = Color(uiColor: config.tintColor)
            let accessories = accessories.map { AnyView($0) }
            
            if accessories.isEmpty {
                EmptyView()
            } else {
                HStack(spacing: spacing) {
                    ForEach(0 ..< accessories.count, id: \.self) {
                        accessories[$0]
                    }
                    .foregroundColor(tintColor)
                }
            }
        }
        
        // MARK: - Property
        @Binding
        var text: String
        var placeholder: String
        
        @Binding
        var isSecureTextEntry: Bool
        @Binding
        var isEditing: Bool
        
        @Environment(\.csuTextField)
        private var config: Configuration
        
        // MARK: - Initializer
        
        // MARK: - Public
        
        // MARK: - Private
    }
    
    // MARK: - View
    public var body: some View {
        AnyView(
            style.makeBody(.init(
                label: .init(
                    Content(
                        text: $text,
                        placeholder: placeholder,
                        isSecureTextEntry: $isSecureTextEntry,
                        isEditing: $isEditing
                    )
                )
            ))
        )
    }
    
    // MARK: - Property
    @Binding
    private var text: String
    public var placeholder: String
    
    @Environment(\.csuTextField.style)
    private var style: any CSUTextFieldStyle
    
    @EnvironmentState(\.csuTextField.isSecureTextEntry)
    private var isSecureTextEntry: Bool = false
    @EnvironmentState(\.csuTextField.isEditing)
    private var isEditing: Bool = false
    
    // MARK: - Initializer
    public init(
        _ placeholder: String = "",
        text: Binding<String>
    ) {
        self._text = text
        self.placeholder = placeholder
    }
    
    // MARK: - Public
    
    // MARK: - Private
}

#if DEBUG
struct CSUTextField_Preview: View {
    @State
    var email: String = ""
    
    @State
    var password: String = ""
    @State
    var passwordIsSecureEntry: Bool = true
    @State
    var passwordFocus: Bool = false
    
    var body: some View {
        VStack {
            CSUTextField(
                "Input e-mail",
                text: $email
            )
                .csuTextField(\.onReturn) {
                    passwordFocus = true
                }
                .fixedSize(horizontal: false, vertical: true)
            
            CSUTextField(
                "Input password",
                text: $password
            )
                .csuTextField(\.isSecureTextEntry, $passwordIsSecureEntry)
                .csuTextField(\.secureTextEntryMode, .whileEditing)
                .csuTextField(\.isEditing, $passwordFocus)
                .fixedSize(horizontal: false, vertical: true)
        }
            .padding(16)
    }
}

struct CSUTextField_Previews: PreviewProvider {
    static var previews: some View {
        CSUTextField_Preview()
            .previewLayout(.sizeThatFits)
    }
}
#endif
