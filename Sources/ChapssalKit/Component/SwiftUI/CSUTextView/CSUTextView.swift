//
//  CSUTextView.swift
//
//
//  Created by JSilver on 2023/02/21.
//

import UIKit
import SwiftUI
import Validator

public struct CSUTextView: View {
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
        public var validator: AnyValidator<String>?
        
        @Config
        public var style: any CSUTextViewStyle = .plain
    }
    
    private struct Content: View {
        // MARK: - View
        var body: some View {
            let backgroundColor = Color(uiColor: config.backgroundColor)
            let borderColor = isEditing ? Color(uiColor: config.tintColor) : Color(uiColor: config.borderColor)
            
            ZStack {
                TextView()
                    .padding(config.contentInsets)
                EdgeGradient()
            }
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
        private func TextView() -> some View {
            ZStack(alignment: .topLeading) {
                // Placeholder
                Text(placeholder)
                    .font(Font(config.font))
                    .foregroundColor(Color(uiColor: config.placeholderColor))
                    .opacity(text.isEmpty ? 1 : 0)
                
                // Text view
                SUTextView(text: $text)
                    .tintColor(config.tintColor)
                    .textColor(config.textColor)
                    .font(config.font)
                    .scrollIndicatorInsets(.init(
                        top: 0,
                        left: 0,
                        bottom: 0,
                        right: -config.contentInsets.trailing
                    ))
                    .editing($isEditing)
                    .autocorrection(config.isAutocorrection)
                    .spellChecking(config.isSpellChecking)
                    .autocapitalization(config.autocapitalization)
                    .returnKeyType(config.returnKeyType)
                    .keyboardType(config.keyboardType)
                    .validator(config.validator)
                    .inputAccessoryView(
                        height: config.inputAccessoryViewHeight,
                        inputAccessoryView: config.inputAccessoryView
                    )
            }
        }
        
        @ViewBuilder
        private func EdgeGradient() -> some View {
            let color = Color(uiColor: config.backgroundColor)
            
            VStack {
                LinearGradient(
                    colors: [
                        color,
                        color,
                        color.opacity(0)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                    .frame(height: 16)
                
                Spacer()
                LinearGradient(
                    colors: [
                        color,
                        color,
                        color.opacity(0)
                    ],
                    startPoint: .bottom,
                    endPoint: .top
                )
                    .frame(height: 16)
            }
        }
        
        // MARK: - Property
        @Binding
        var text: String
        var placeholder: String
        
        @Binding
        var isEditing: Bool
        
        @Environment(\.csuTextView)
        var config: Configuration
        
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
    
    @Environment(\.csuTextView.style)
    private var style: any CSUTextViewStyle
    
    @EnvironmentState(\.csuTextView.isEditing)
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
struct CSUTextView_Preview: View {
    var body: some View {
        VStack {
            CSUTextView("Hello world", text: $text)
                .frame(height: 120)
        }
            .padding(16)
        
    }
    
    @State
    var text: String = ""
}

struct CSUTextView_Previews: PreviewProvider {
    static var previews: some View {
        CSUTextView_Preview()
            .previewLayout(.sizeThatFits)
    }
}
#endif
