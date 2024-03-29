//
//  CSULineButtonStyle.swift
//  
//
//  Created by JSilver on 2023/02/21.
//

import SwiftUI
import Lottie

public struct CSULineButtonStyle: CSUButtonStyle {
    private struct Content: View {
        // MARK: - View
        var body: some View {
            configuration.label
                .csuButton(
                    \.textColor,
                     config.$textColor(Color(uiColor: isEnabled ? R.Color.green01 : R.Color.gray03))
                )
                .csuButton(
                    \.imageColor,
                     config.$imageColor(Color(uiColor: isEnabled ? R.Color.green01 : R.Color.gray03))
                )
                .csuButton(
                    \.backgroundColor,
                     config.$backgroundColor(.clear)
                )
                .csuButton(
                    \.animation,
                     config.$animation(isEnabled ? R.Lottie.loadingGreen : R.Lottie.loadingGray)
                )
                .csuButton(
                    \.cornerRadius,
                     config.$cornerRadius(8)
                )
                .csuButton(
                    \.borderColor,
                     config.$borderColor(Color(uiColor: isEnabled ? R.Color.green01 : R.Color.gray04))
                )
                .csuButton(
                    \.borderWidth,
                     config.$borderWidth(1)
                )
        }
        
        // MARK: - Property
        private let configuration: CSUButtonStyleConfiguration
        
        @Environment(\.isEnabled)
        private var isEnabled: Bool
        
        @Environment(\.csuButton)
        private var config: CSUButton.Configuration
        
        // MARK: - Initializer
        init(_ configuration: Configuration) {
            self.configuration = configuration
        }
    }
    
    public func makeBody(_ configuration: Configuration) -> some View {
        Content(configuration)
    }
}
