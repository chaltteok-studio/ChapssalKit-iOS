//
//  CSUTextFieldStyle.swift
//  
//
//  Created by JSilver on 2023/03/11.
//

import SwiftUI

public protocol CSUTextFieldStyle {
    associatedtype Body: View
    typealias Configuration = CSUTextFieldStyleConfiguration
    
    func makeBody(_ configuration: Configuration) -> Body
}

public extension CSUTextFieldStyle where Self == CSUPlainTextFieldStyle {
    static var plain: Self { CSUPlainTextFieldStyle() }
}

public extension CSUTextFieldStyle {
    static func inputBox(state: any CSUInputBoxState = CSUInputBoxStyle.State.normal) -> Self where Self == CSUInputBoxStyle {
        CSUInputBoxStyle(state: state)
    }
    
    static func inputLine(state: any CSUInputLineState = CSUInputLineStyle.State.normal) -> Self where Self == CSUInputLineStyle {
        CSUInputLineStyle(state: state)
    }
}

public struct CSUTextFieldStyleConfiguration {
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
    
    // MARK: - Initlalizer
    
    // MARK: - Public
    
    // MARK: - Private
}

public struct CSUPlainTextFieldStyle: CSUTextFieldStyle {
    struct Content: View {
        // MARK: - View
        var body: some View {
            configuration.label
        }
        
        // MARK: - Property
        let configuration: CSUTextFieldStyleConfiguration
        
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
