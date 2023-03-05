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
        @Default(R.Color.gray01)
        public var textColor: UIColor?
        @Default(R.Color.green01)
        public var tintColor: UIColor?
        @Default(R.Font.font(ofSize: 16, weight: .medium))
        public var font: UIFont?
        @Default(EdgeInsets(top: 14, leading: 12, bottom: 14, trailing: 12))
        public var contentInsets: EdgeInsets?
        
        public var isSecureTextEntry: Binding<Bool>?
        @Default(false)
        public var isAutocorrection: Bool?
        @Default(false)
        public var isSpellChecking: Bool?
        @Default(.none)
        public var autocapitalization: UITextAutocapitalizationType?
        
        @Default(.default)
        public var keyboardType: UIKeyboardType?
        @Default(.default)
        public var returnKeyType: UIReturnKeyType?
        
        @Default(0)
        public var inputAccessoryViewHeight: CGFloat?
        public var inputAccessoryView: (any View)?
        
        @Default(.whileEditing)
        public var clearButtonMode: ClearButtonMode?
        @Default(.never)
        public var secureTextEntryMode: SecureTextEntryMode?
        
        @Default([])
        public var leftAccessories: [any View]?
        @Default(0)
        public var leftInterAccessoriesSpacing: CGFloat?
        @Default([])
        public var rightAccessories: [any View]?
        @Default(0)
        public var rightInterAccessoriesSpacing: CGFloat?
        
        @Default(R.Color.white)
        public var backgroundColor: UIColor?
        
        @Default(8)
        public var cornerRadius: CGFloat?
        @Default(.all)
        public var borderEdges: Edge.Set?
        @Default(R.Color.gray04)
        public var borderColor: UIColor?
        @Default(1)
        public var borderWidth: CGFloat?
        
        public var isEditing: Binding<Bool>?
        
        public var onReturn: (() -> Void)?
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
    
    // MARK: - View
    public var body: some View {
        let backgroundColor = Color(uiColor: config.$backgroundColor)
        let borderColor = isEditing ? Color(uiColor: config.$tintColor) : Color(uiColor: config.$borderColor)
        
        ZStack {
            ContentView()
        }
            .frame(minHeight: 52)
            .background(backgroundColor)
            .cornerRadius(config.$cornerRadius)
            .overlay(
                EdgeBorder(
                    edges: config.$borderEdges,
                    cornerRadius: config.$cornerRadius
                )
                .stroke(
                    borderColor,
                    lineWidth: config.$borderWidth
                )
            )
    }
    
    @ViewBuilder
    private func Root(
        placeholder: String,
        text: Binding<String>
    ) -> some View {
        let backgroundColor = Color(uiColor: config.$backgroundColor)
        let borderColor = isEditing ? Color(uiColor: config.$tintColor) : Color(uiColor: config.$borderColor)
        
        ZStack {
            ContentView()
        }
            .frame(minHeight: 52)
            .background(backgroundColor)
            .cornerRadius(config.$cornerRadius)
            .overlay(
                EdgeBorder(
                    edges: config.$borderEdges,
                    cornerRadius: config.$cornerRadius
                )
                .stroke(
                    borderColor,
                    lineWidth: config.$borderWidth
                )
            )
    }
    
    @ViewBuilder
    private func ContentView() -> some View {
        HStack(spacing: 12) {
            Accessories(
                spacing: config.$leftInterAccessoriesSpacing,
                config.$leftAccessories
            )
                .layoutPriority(1)
            
            HStack(spacing: 0) {
                TextField()
                ClearButton()
            }
            
            SecureTextEntryButton()
            
            Accessories(
                spacing: config.$rightInterAccessoriesSpacing,
                config.$rightAccessories
            )
                .layoutPriority(1)
        }
            .padding(config.$contentInsets)
    }
    
    @ViewBuilder
    private func TextField() -> some View {
        let backgroundColor = Color(uiColor: config.$backgroundColor)
        
        ZStack(alignment: .trailing) {
            UITextFieldView(placeholder, text: $text)
                .textColor(config.$textColor)
                .tintColor(config.$tintColor)
                .font(config.$font)
                .editing($isEditing)
                .secureTextEntry(isSecureTextEntry)
                .autocorrection(config.$isAutocorrection)
                .spellChecking(config.$isSpellChecking)
                .autocapitalization(config.$autocapitalization)
                .returnKeyType(config.$returnKeyType)
                .keyboardType(config.$keyboardType)
                .inputAccessoryView(
                    height: config.$inputAccessoryViewHeight,
                    inputAccessoryView: config.inputAccessoryView
                )
                .onReturn {
                    config.onReturn?()
                }
            
            LinearGradient(
                colors: [
                    backgroundColor.opacity(0),
                    backgroundColor
                ],
                startPoint: .init(x: 0, y: 0.5),
                endPoint: .init(x: 1, y: 0.5)
            )
                .frame(width: 24)
                .allowsHitTesting(false)
        }
    }
    
    @ViewBuilder
    private func ClearButton() -> some View {
        if !config.$clearButtonMode.isHidden(
            text: text,
            isEditing: isEditing
        ) {
            Button {
                text = ""
            } label: {
                Image(uiImage: R.Icon.ic24Clear)
                    .foregroundColor(Color(uiColor: R.Color.gray04))
            }
                .buttonStyle(.none)
        }
    }
    
    @ViewBuilder
    private func SecureTextEntryButton() -> some View {
        let image = isSecureTextEntry ? R.Icon.ic24Vision : R.Icon.ic24Blind
        let color = isEditing ? config.$tintColor : R.Color.gray04
        
        if !config.$secureTextEntryMode.isHidden(
            text: text,
            isEditing: isEditing
        ) {
            Button {
                isSecureTextEntry.toggle()
            } label: {
                Image(uiImage: image)
                    .foregroundColor(Color(uiColor: color))
            }
                .buttonStyle(.none)
        }
    }
    
    @ViewBuilder
    private func Accessories(
        spacing: CGFloat,
        _ accessories: [any View]
    ) -> some View {
        let tintColor = Color(uiColor: config.$tintColor)
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
    private var text: String
    public var placeholder: String
    
    @Environment(\.csuTextField)
    private var config: Configuration
    
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
            CSUInputBox(
                "Input e-mail",
                text: $email
            )
                .fixedSize(horizontal: false, vertical: true)
                .csuTextField(\.onReturn) {
                    passwordFocus = true
                }
            
            CSUInputBox(
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
