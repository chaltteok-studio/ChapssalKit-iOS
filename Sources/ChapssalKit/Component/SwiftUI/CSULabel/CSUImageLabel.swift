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
    
    // MARK: - View
    public var body: some View {
        switch direction {
        case .top:
            VStack(spacing: spacing) {
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
            HStack(spacing: spacing) {
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
            VStack(spacing: spacing) {
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
            HStack(spacing: spacing) {
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
    
    @Environment(\.csuImageLabel)
    private var config: Configuration
    
    // MARK: - Initializer
    public init(
        text: String? = nil,
        image: Image? = nil,
        spacing: CGFloat = 0,
        direction: Direction = .leading
    ) {
        self.text = text
        self.image = image
        self.spacing = spacing
        self.direction = direction
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
                    direction: .top
                )
                    .border(Color.black)
                CSUImageLabel(
                    text: "Like",
                    image: .init(systemName: "heart.fill"),
                    spacing: spacing,
                    direction: .trailing
                )
                    .border(Color.black)
                CSUImageLabel(
                    text: "Like",
                    image: .init(systemName: "heart.fill"),
                    spacing: spacing,
                    direction: .bottom
                )
                    .border(Color.black)
                CSUImageLabel(
                    text: "Like",
                    image: .init(systemName: "heart.fill"),
                    spacing: spacing,
                    direction: .leading
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
