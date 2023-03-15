//
//  CSUImageLabel.swift
//  
//
//  Created by JSilver on 2023/02/21.
//

import SwiftUI

public struct CSUImageLabel: View {
    struct ConfigurationKey: EnvironmentKey {
        static var defaultValue = Configuration()
    }
    
    public struct Configuration {
        @Config
        public var textColor: Color = Color(uiColor: R.Color.black)
        @Config
        public var imageColor: Color = Color(uiColor: R.Color.black)
        @Config
        public var font: Font = Font(R.Font.font(ofSize: 16, weight: .medium))
    }
    
    public enum Direction {
        case top
        case leading
        case bottom
        case trailing
    }
    
    public enum Alignment {
        case leading
        case center
        case trailing
        
        var verticalAlignment: VerticalAlignment {
            switch self {
            case .leading:
                return .top
                
            case .center:
                return .center
                
            case .trailing:
                return .bottom
            }
        }
        
        var horizontalAlignment: HorizontalAlignment {
            switch self {
            case .leading:
                return .leading
                
            case .center:
                return .center
                
            case .trailing:
                return .trailing
            }
        }
    }
    
    // MARK: - View
    public var body: some View {
        switch direction {
        case .top:
            VStack(
                alignment: alignment.horizontalAlignment,
                spacing: spacing
            ) {
                if let image {
                    image
                        .foregroundColor(config.imageColor)
                }
                if let text {
                    Text(text)
                        .foregroundColor(config.textColor)
                        .font(config.font)
                }
            }
            
        case .trailing:
            HStack(
                alignment: alignment.verticalAlignment,
                spacing: spacing
            ) {
                if let text {
                    Text(text)
                        .foregroundColor(config.textColor)
                        .font(config.font)
                }
                if let image {
                    image
                        .foregroundColor(config.imageColor)
                }
            }
            
        case .bottom:
            VStack(
                alignment: alignment.horizontalAlignment,
                spacing: spacing
            ) {
                if let text {
                    Text(text)
                        .foregroundColor(config.textColor)
                        .font(config.font)
                }
                if let image {
                    image
                        .foregroundColor(config.imageColor)
                }
            }
            
        case .leading:
            HStack(
                alignment: alignment.verticalAlignment,
                spacing: spacing
            ) {
                if let image {
                    image
                        .foregroundColor(config.imageColor)
                }
                if let text {
                    Text(text)
                        .foregroundColor(config.textColor)
                        .font(config.font)
                }
            }
        }
    }
    
    // MARK: - Property
    public var text: String?
    public var image: Image?
    public var spacing: CGFloat
    public var direction: Direction
    public var alignment: Alignment
    
    @Environment(\.csuImageLabel)
    private var config: Configuration
    
    // MARK: - Initializer
    public init(
        text: String? = nil,
        image: Image? = nil,
        spacing: CGFloat = 0,
        direction: Direction = .leading,
        alignment: Alignment = .center
    ) {
        self.text = text
        self.image = image
        self.spacing = spacing
        self.direction = direction
        self.alignment = alignment
    }
    
    // MARK: - Public
    
    // MARK: - Private
}

#if DEBUG
struct CSUImageLabel_Preview: View {
    var body: some View {
        VStack {
            VStack(spacing: 8) {
                CSUImageLabel(
                    text: "Like",
                    image: .init(systemName: "heart.fill"),
                    spacing: spacing,
                    direction: .top,
                    alignment: .leading
                )
                    .border(Color.black)
                CSUImageLabel(
                    text: "Like",
                    image: .init(systemName: "heart.fill"),
                    spacing: spacing,
                    direction: .trailing,
                    alignment: .leading
                )
                    .border(Color.black)
                CSUImageLabel(
                    text: "Like",
                    image: .init(systemName: "heart.fill"),
                    spacing: spacing,
                    direction: .bottom,
                    alignment: .leading
                )
                    .border(Color.black)
                CSUImageLabel(
                    text: "Like",
                    image: .init(systemName: "heart.fill"),
                    spacing: spacing,
                    direction: .leading,
                    alignment: .leading
                )
                    .border(Color.black)
                CSUImageLabel(
                    text: "Like"
                )
                    .border(Color.black)
                CSUImageLabel(
                    image: .init(systemName: "heart.fill")
                )
                    .border(Color.black)
            }

            Slider(value: $spacing, in: 0...10, step: 1)
                .tint(.black)
        }
            .padding()
    }
    
    @State
    private var spacing: CGFloat = 10.0
}

struct CSUImageLabel_Previews: PreviewProvider {
    static var previews: some View {
        CSUImageLabel_Preview()
    }
}

#endif
