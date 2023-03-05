//
//  CSUButton.swift
//  
//
//  Created by JSilver on 2023/02/17.
//

import SwiftUI
import Lottie

public struct CSUButton: View {
    struct ConfigurationKey: EnvironmentKey {
        static var defaultValue = Configuration()
    }
    
    public struct Configuration {
        @Default(Color(uiColor: R.Color.white))
        public var textColor: Color?
        @Default(Color(uiColor: R.Color.white))
        public var imageColor: Color?
        @Default(Font(R.Font.font(ofSize: 16, weight: .medium)))
        public var font: Font?
        @Default(EdgeInsets(top: 14, leading: 14, bottom: 14, trailing: 14))
        public var contentInsets: EdgeInsets?
        
        @Default(Color(uiColor: R.Color.green01))
        public var backgroundColor: Color?
        @Default(Color(uiColor: R.Color.white.withAlphaComponent(0.3)))
        public var pressedColor: Color?
        
        @Default(0)
        public var cornerRadius: CGFloat?
        @Default(0)
        public var borderWidth: CGFloat?
        @Default(Color(uiColor: R.Color.green01))
        public var borderColor: Color?
        
        @Default(R.Lottie.loadingWhite)
        public var animation: LottieAnimation?
        @Default(false)
        public var isLoading: Bool?
    }
    
    // MARK: - View
    public var body: some View {
        Button {
            action()
        } label: {
            ButtonLabel()
        }
            .buttonStyle(.highlight($isHighlight))
    }
    
    @ViewBuilder
    private func ButtonLabel() -> some View {
        ZStack {
            ContentView()
            HighlightView()
        }
            .frame(
                maxWidth: .infinity,
                minHeight: 52,
                maxHeight: .infinity
            )
            .background(config.$backgroundColor)
            .cornerRadius(config.$cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: config.$cornerRadius)
                    .stroke(config.$borderColor, lineWidth: config.$borderWidth)
            )
    }
    
    @ViewBuilder
    private func ContentView() -> some View {
        ZStack {
            CSUImageLabel(
                text: title,
                image: image,
                spacing: spacing,
                direction: direction
            )
                .csuImageLabel(\.textColor, config.$textColor)
                .csuImageLabel(\.imageColor, config.$imageColor)
                .font(config.$font)
                .opacity(config.$isLoading ? 0 : 1)
            
            AnimationView(
                animation: config.$animation,
                loopMode: .loop
            )
                .loading(config.$isLoading)
                .opacity(config.$isLoading ? 1 : 0)
                .fixedSize()
        }
            .padding(config.$contentInsets)
    }
    
    @ViewBuilder
    private func HighlightView() -> some View {
        if isHighlight {
            config.$pressedColor
        }
    }
    
    // MARK: - Property
    public var title: String?
    public var image: Image?
    public var spacing: CGFloat
    public var direction: CSUImageLabel.Direction
    
    public var action: () -> Void
    
    @State
    private var isHighlight: Bool = false
    
    @Environment(\.csuButton)
    private var config: Configuration
    
    // MARK: - Initializer
    public init(
        title: String? = nil,
        image: Image? = nil,
        spacing: CGFloat = 0,
        direction: CSUImageLabel.Direction = .leading,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.image = image
        self.spacing = spacing
        self.direction = direction
        self.action = action
    }
    
    // MARK: - Public
    
    // MARK: - Private
}

#if DEBUG
struct CSUButton_Preview: View {
    var body: some View {
        VStack {
            VStack {
                HStack {
                    CSUTextButton(title: "Text") { }
                        .fixedSize()
                    
                    CSUTextButton(title: "Text") { }
                        .csuButton(\.isLoading, true)
                        .fixedSize()
                }
                
                HStack {
                    CSUTextButton(title: "Text") { }
                        .disabled(true)
                        .fixedSize()
                    
                    CSUTextButton(title: "Text") { }
                        .csuButton(\.isLoading, true)
                        .disabled(true)
                        .fixedSize()
                }
            }
            
            VStack {
                HStack {
                    CSUFillButton(title: "Fill") { }
                        .fixedSize()
                    
                    CSUFillButton(title: "Fill") { }
                        .csuButton(\.isLoading, true)
                        .fixedSize()
                }
                
                HStack {
                    CSUFillButton(title: "Fill") { }
                        .disabled(true)
                        .fixedSize()
                    
                    CSUFillButton(title: "Fill") { }
                        .csuButton(\.isLoading, true)
                        .disabled(true)
                        .fixedSize()
                }
            }
            
            VStack {
                HStack {
                    CSUFillButton(title: "Fill") { }
                        .csuButton(\.cornerRadius, 0)
                        .fixedSize()
                    
                    CSUFillButton(title: "Fill") { }
                        .csuButton(\.cornerRadius, 0)
                        .csuButton(\.isLoading, true)
                        .fixedSize()
                }
                
                HStack {
                    CSUFillButton(title: "Fill") { }
                        .csuButton(\.cornerRadius, 0)
                        .disabled(true)
                        .fixedSize()
                    
                    CSUFillButton(title: "Fill") { }
                        .csuButton(\.cornerRadius, 0)
                        .csuButton(\.isLoading, true)
                        .disabled(true)
                        .fixedSize()
                }
            }
            
            VStack {
                HStack {
                    CSULineButton(title: "Line") { }
                        .fixedSize()
                    
                    CSULineButton(title: "Line") { }
                        .csuButton(\.isLoading, true)
                        .fixedSize()
                }
                
                HStack {
                    CSULineButton(title: "Line") { }
                        .disabled(true)
                        .fixedSize()
                    
                    CSULineButton(title: "Line") { }
                        .csuButton(\.isLoading, true)
                        .disabled(true)
                        .fixedSize()
                }
            }
            
            VStack {
                HStack {
                    CSUButton(title: "Text") { }
                        .csuButton(\.font, Font(R.Font.font(ofSize: 88, weight: .bold)))
                        .csuButton(\.contentInsets, .init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .fixedSize()
                    
                    CSUButton(title: "Text") { }
                        .csuButton(\.font, Font(R.Font.font(ofSize: 88, weight: .bold)))
                        .csuButton(
                            \.contentInsets,
                             .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                        )
                        .csuButton(\.isLoading, true)
                        .fixedSize()
                }
            }
            
            VStack {
                HStack {
                    CSUButton(image: Image(uiImage: R.Icon.ic24Archive)) { }
                        .csuButton(\.animation, nil)
                        .csuButton(\.cornerRadius, 26)
                        .fixedSize()
                    
                    CSUButton(title: "Text") { }
                        .csuButton(\.font, Font(R.Font.font(ofSize: 12, weight: .bold)))
                        .fixedSize()
                    
                    CSUButton(title: "Text") { }
                        .csuButton(\.font, Font(R.Font.font(ofSize: 12, weight: .bold)))
                        .csuButton(\.isLoading, true)
                        .fixedSize()
                }
            }
        }
    }
}

struct CSUButton_Previews: PreviewProvider {
    static var previews: some View {
        CSUButton_Preview()
            .background(Color(red: 0.9, green: 0.9, blue: 0.9))
            .previewLayout(.sizeThatFits)
    }
}
#endif
