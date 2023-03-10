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
        @Config
        public var textColor: Color = Color(uiColor: R.Color.white)
        @Config
        public var imageColor: Color = Color(uiColor: R.Color.white)
        @Config
        public var font: Font = Font(R.Font.font(ofSize: 16, weight: .medium))
        @Config
        public var contentInsets: EdgeInsets = EdgeInsets(top: 14, leading: 14, bottom: 14, trailing: 14)
        
        @Config
        public var backgroundColor: Color = Color(uiColor: R.Color.green01)
        @Config
        public var pressedColor: Color = Color(uiColor: R.Color.white.withAlphaComponent(0.3))
        
        @Config
        public var cornerRadius: CGFloat = 0
        @Config
        public var borderWidth: CGFloat = 0
        @Config
        public var borderColor: Color = Color(uiColor: R.Color.green01)
        
        @Config
        public var animation: LottieAnimation? = R.Lottie.loadingWhite
        @Config
        public var isLoading: Bool = false
        
        @Config
        public var style: any CSUButtonStyle = .plain
    }
    
    private struct Content: View {
        // MARK: - View
        var body: some View {
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
                .background(config.backgroundColor)
                .cornerRadius(config.cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: config.cornerRadius)
                        .stroke(config.borderColor, lineWidth: config.borderWidth)
                )
                .contentShape(Rectangle())
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
                    .csuImageLabel(\.textColor, config.textColor)
                    .csuImageLabel(\.imageColor, config.imageColor)
                    .csuImageLabel(\.font, config.font)
                    .opacity(config.isLoading ? 0 : 1)
                
                if let animation = config.animation {
                    AnimationView(
                        animation: animation,
                        loopMode: .loop
                    )
                        .loading(config.isLoading)
                        .opacity(config.isLoading ? 1 : 0)
                        .fixedSize()
                }
            }
                .padding(config.contentInsets)
        }
        
        @ViewBuilder
        private func HighlightView() -> some View {
            if isHighlight {
                config.pressedColor
            }
        }
        
        // MARK: - Property
        var title: String?
        var image: Image?
        var spacing: CGFloat
        var direction: CSUImageLabel.Direction
        
        @Binding
        var isHighlight: Bool
        
        var action: () -> Void
        
        @Environment(\.csuButton)
        private var config: CSUButton.Configuration
        
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
                        title: title,
                        image: image,
                        spacing: spacing,
                        direction: direction,
                        isHighlight: $isHighlight,
                        action: action
                    )
                ),
                isPressed: isHighlight
            ))
        )
    }
    
    // MARK: - Property
    public var title: String?
    public var image: Image?
    public var spacing: CGFloat
    public var direction: CSUImageLabel.Direction
    
    @State
    private var isHighlight: Bool = false
    
    public var action: () -> Void
    
    @Environment(\.csuButton.style)
    private var style: any CSUButtonStyle
    
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
        ScrollView {
            VStack {
                VStack(alignment: .leading) {
                    Text("Default")
                        .font(Font(R.Font.font(ofSize: 14, weight: .light)))
                    HStack {
                        CSUButton(title: "Default") { }
                            .fixedSize(horizontal: false, vertical: true)
                        
                        CSUButton(title: "Default") { }
                            .csuButton(\.isLoading, true)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Text")
                        .font(Font(R.Font.font(ofSize: 14, weight: .light)))
                    HStack {
                        CSUButton(title: "Text") { }
                            .csuButton(\.style, .text)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        CSUButton(title: "Text") { }
                            .csuButton(\.style, .text)
                            .csuButton(\.isLoading, true)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    HStack {
                        CSUButton(title: "Text") { }
                            .csuButton(\.style, .text)
                            .disabled(true)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        CSUButton(title: "Text") { }
                            .csuButton(\.style, .text)
                            .csuButton(\.isLoading, true)
                            .disabled(true)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Fill")
                        .font(Font(R.Font.font(ofSize: 14, weight: .light)))
                    HStack {
                        CSUButton(title: "Fill") { }
                            .csuButton(\.style, .fill)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        CSUButton(title: "Fill") { }
                            .csuButton(\.style, .fill)
                            .csuButton(\.isLoading, true)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    HStack {
                        CSUButton(title: "Fill") { }
                            .csuButton(\.style, .fill)
                            .disabled(true)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        CSUButton(title: "Fill") { }
                            .csuButton(\.style, .fill)
                            .disabled(true)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Line")
                        .font(Font(R.Font.font(ofSize: 14, weight: .light)))
                    HStack {
                        CSUButton(title: "Line") { }
                            .csuButton(\.style, .line)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        CSUButton(title: "Line") { }
                            .csuButton(\.style, .line)
                            .csuButton(\.isLoading, true)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    HStack {
                        CSUButton(title: "Line") { }
                            .csuButton(\.style, .line)
                            .disabled(true)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        CSUButton(title: "Line") { }
                            .csuButton(\.style, .line)
                            .csuButton(\.isLoading, true)
                            .disabled(true)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Fixed Size")
                        .font(Font(R.Font.font(ofSize: 14, weight: .light)))
                    HStack {
                        Spacer()
                        
                        CSUButton(title: "Fixed") { }
                            .fixedSize()
                        
                        CSUButton(title: "Fixed") { }
                            .csuButton(\.style, .fill)
                            .fixedSize()
                        
                        CSUButton(title: "Fixed") { }
                            .csuButton(\.style, .line)
                            .fixedSize()
                        
                        CSUButton(title: "Fixed") { }
                            .csuButton(\.style, .text)
                            .fixedSize()
                        
                        Spacer()
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Custom")
                        .font(Font(R.Font.font(ofSize: 14, weight: .light)))
                    
                    HStack {
                        CSUButton(image: Image(uiImage: R.Icon.ic24Archive)) { }
                            .csuButton(\.animation, nil)
                            .csuButton(\.cornerRadius, 26)
                            .fixedSize()
                        
                        CSUButton(title: "Custom") { }
                            .csuButton(\.contentInsets, .init(.zero))
                            .csuButton(\.backgroundColor, .blue)
                            .csuButton(\.font, Font(R.Font.font(ofSize: 48, weight: .regular)))
                            .fixedSize()
                    }
                }
            }
        }
            .padding(.horizontal, 16)
            .background(Color(uiColor: .systemGroupedBackground))
    }
}

struct CSUButton_Previews: PreviewProvider {
    static var previews: some View {
        CSUButton_Preview()
    }
}
#endif
