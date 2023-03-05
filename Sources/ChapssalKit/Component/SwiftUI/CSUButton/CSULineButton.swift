//
//  CSULineButton.swift
//  
//
//  Created by JSilver on 2023/02/21.
//

import SwiftUI
import Lottie

public struct CSULineButton: View {
    // MARK: - View
    public var body: some View {
        CSUButton(
            title: title,
            image: image,
            spacing: spacing,
            direction: direction,
            action: action
        )
            .csuButton(
                \.textColor,
                 config.textColor ?? Color(uiColor: isEnabled ? R.Color.green01 : R.Color.gray03)
            )
            .csuButton(
                \.backgroundColor,
                 config.backgroundColor ?? .clear
            )
            .csuButton(
                \.animation,
                 config.animation ?? (isEnabled ? R.Lottie.loadingGreen : R.Lottie.loadingGray)
            )
            .csuButton(
                \.cornerRadius,
                 config.cornerRadius ?? 8
            )
            .csuButton(
                \.borderColor,
                 config.borderColor ?? Color(uiColor: isEnabled ? R.Color.green01 : R.Color.gray04)
            )
            .csuButton(
                \.borderWidth,
                 config.borderWidth ?? 1
            )
    }
    
    // MARK: - Property
    public var title: String?
    public var image: Image?
    public var spacing: CGFloat
    public var direction: CSUImageLabel.Direction
    
    public var action: () -> Void
    
    @Environment(\.isEnabled)
    public var isEnabled: Bool
    
    @Environment(\.csuButton)
    private var config: CSUButton.Configuration
    
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
