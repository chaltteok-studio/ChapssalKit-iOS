//
//  CSUFillButton.swift
//  
//
//  Created by JSilver on 2023/02/21.
//

import SwiftUI
import Lottie
import Charts

public struct CSUFillButton: View {
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
                 config.textColor ?? Color(uiColor: R.Color.white)
            )
            .csuButton(
                \.backgroundColor,
                 config.backgroundColor ?? Color(uiColor: isEnabled ? R.Color.green01 : R.Color.gray04)
            )
            .csuButton(
                \.animation,
                 config.animation ?? (isEnabled ? R.Lottie.loadingWhite : R.Lottie.loadingGray)
            )
            .csuButton(
                \.cornerRadius,
                 config.cornerRadius ?? 8
            )
            .csuButton(
                \.borderWidth,
                 config.borderWidth ?? 0
            )
    }
    
    // MARK: - Property
    public var title: String?
    public var image: Image?
    public var spacing: CGFloat
    public var direction: CSUImageLabel.Direction
    
    public var action: () -> Void
    
    @Environment(\.isEnabled)
    private var isEnabled: Bool
    
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
