//
//  CSUButtonStyle.swift
//  
//
//  Created by JSilver on 2023/03/10.
//

import SwiftUI

public protocol CSUButtonStyle {
    associatedtype Body: View
    typealias Configuration = CSUButtonStyleConfiguration
    
    func makeBody(_ configuration: Configuration) -> Body
}

public extension CSUButtonStyle where Self == CSUPlainButtonStyle {
    static var plain: Self { CSUPlainButtonStyle() }
}

public extension CSUButtonStyle where Self == CSUFillButtonStyle {
    static var fill: Self { CSUFillButtonStyle() }
}

public extension CSUButtonStyle where Self == CSULineButtonStyle {
    static var line: Self { CSULineButtonStyle() }
}

public extension CSUButtonStyle where Self == CSUTextButtonStyle {
    static var text: Self { CSUTextButtonStyle() }
}

public struct CSUButtonStyleConfiguration {
    public struct Label: View {
        // MARK: - View
        public var body: AnyView
        
        // MARK: - Property
        
        // MARK: - Initlalizer
        init<Content: View>(_ content: Content) {
            self.body = AnyView(content)
        }
        
        // MARK: - Public
        
        // MARK: - Private
    }
    
    // MARK: - Property
    public let label: Label
    public let isPressed: Bool
    
    // MARK: - Initlalizer
    
    // MARK: - Public
    
    // MARK: - Private
}

public struct CSUPlainButtonStyle: CSUButtonStyle {
    struct Content: View {
        // MARK: - View
        var body: some View {
            configuration.label
        }
        
        // MARK: - Property
        let configuration: CSUButtonStyleConfiguration
        
        // MARK: - Initlalizer
        init(_ configuration: Configuration) {
            self.configuration = configuration
        }
        
        // MARK: - Public
        
        // MARK: - Private
    }
    
    public func makeBody(_ configuration: Configuration) -> some View {
        Content(configuration)
    }
}
