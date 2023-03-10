//
//  CSUFillButtonStyle.swift
//  
//
//  Created by JSilver on 2023/02/21.
//

import SwiftUI
import Lottie

public struct CSUFillButtonStyle: CSUButtonStyle {
    private struct Content: View {
        // MARK: - View
        var body: some View {
            configuration.label
                .csuButton(
                    \.textColor,
                     config.$textColor(Color(uiColor: R.Color.white))
                )
                .csuButton(
                    \.backgroundColor,
                     config.$backgroundColor(Color(uiColor: isEnabled ? R.Color.green01 : R.Color.gray04))
                )
                .csuButton(
                    \.animation,
                     config.$animation(isEnabled ? R.Lottie.loadingWhite : R.Lottie.loadingGray)
                )
                .csuButton(
                    \.cornerRadius,
                     config.$cornerRadius(8)
                )
                .csuButton(
                    \.borderWidth,
                     config.$borderWidth(0)
                )
        }
        
        // MARK: - Property
        let configuration: CSUButtonStyleConfiguration
        
        @Environment(\.isEnabled)
        var isEnabled: Bool
        
        @Environment(\.csuButton)
        var config: CSUButton.Configuration
        
        // MARK: - Initializer
        init(_ configuration: Configuration) {
            self.configuration = configuration
        }
    }
    
    public func makeBody(_ configuration: Configuration) -> some View {
        Content(configuration)
    }
}
