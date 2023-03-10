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
        
        public var animation: LottieAnimation? = R.Lottie.loadingWhite
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
                .csuImageLabel(\.textColor, config.$textColor)
                .csuImageLabel(\.imageColor, config.$imageColor)
                .csuImageLabel(\.font, config.$font)
                .opacity(config.$isLoading ? 0 : 1)
            
            if let animation = config.animation {
                AnimationView(
                    animation: animation,
                    loopMode: .loop
                )
                    .loading(config.$isLoading)
                    .opacity(config.$isLoading ? 1 : 0)
                    .fixedSize()
            }
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
                    
                    HStack {
                        CSUButton(title: "Default") { }
                            .disabled(true)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        CSUButton(title: "Default") { }
                            .csuButton(\.isLoading, true)
                            .disabled(true)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Text")
                        .font(Font(R.Font.font(ofSize: 14, weight: .light)))
                    HStack {
                        CSUTextButton(title: "Text") { }
                            .fixedSize(horizontal: false, vertical: true)
                        
                        CSUTextButton(title: "Text") { }
                            .csuButton(\.isLoading, true)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    HStack {
                        CSUTextButton(title: "Text") { }
                            .disabled(true)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        CSUTextButton(title: "Text") { }
                            .csuButton(\.isLoading, true)
                            .disabled(true)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Fill")
                        .font(Font(R.Font.font(ofSize: 14, weight: .light)))
                    HStack {
                        CSUFillButton(title: "Fill") { }
                            .fixedSize(horizontal: false, vertical: true)
                        
                        CSUFillButton(title: "Fill") { }
                            .csuButton(\.isLoading, true)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    HStack {
                        CSUFillButton(title: "Fill") { }
                            .disabled(true)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        CSUFillButton(title: "Fill") { }
                            .csuButton(\.isLoading, true)
                            .disabled(true)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Line")
                        .font(Font(R.Font.font(ofSize: 14, weight: .light)))
                    HStack {
                        CSULineButton(title: "Line") { }
                            .fixedSize(horizontal: false, vertical: true)
                        
                        CSULineButton(title: "Line") { }
                            .csuButton(\.isLoading, true)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    HStack {
                        CSULineButton(title: "Line") { }
                            .disabled(true)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        CSULineButton(title: "Line") { }
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
                        
                        CSUFillButton(title: "Fixed") { }
                            .fixedSize()
                        
                        CSUTextButton(title: "Fixed") { }
                            .fixedSize()
                        
                        CSULineButton(title: "Fixed") { }
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
                            .csuButton(\.font, Font(R.Font.font(ofSize: 48, weight: .regular)))
                            .fixedSize()
                    }
                }
            }
                .ignoresSafeArea()
        }
            .padding(.horizontal, 16)
    }
}

struct CSUButton_Previews: PreviewProvider {
    static var previews: some View {
        CSUButton_Preview()
    }
}
#endif
