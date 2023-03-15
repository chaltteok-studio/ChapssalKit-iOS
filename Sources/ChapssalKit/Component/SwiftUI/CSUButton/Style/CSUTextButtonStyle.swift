//
//  CSUTextButtonStyle.swift.swift
//  
//
//  Created by JSilver on 2023/02/21.
//

import SwiftUI
import Lottie

public struct CSUTextButtonStyle: CSUButtonStyle {
    private struct Content: View {
        // MARK: - View
        var body: some View {
            configuration.label
                .csuButton(
                    \.textColor,
                     config.$textColor(Color(uiColor: isEnabled ? R.Color.green01 : R.Color.gray04))
                )
                .csuButton(
                    \.imageColor,
                     config.$imageColor(Color(uiColor: isEnabled ? R.Color.green01 : R.Color.gray04))
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
