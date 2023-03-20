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
    static func boxInput(state: any CSUBoxInputState = CSUBoxInputStyle.State.normal) -> Self where Self == CSUBoxInputStyle {
        CSUBoxInputStyle(state: state)
    }
    
    static func lineInput(state: any CSULineInputState = CSULineInputStyle.State.normal) -> Self where Self == CSULineInputStyle {
        CSULineInputStyle(state: state)
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
    private struct Content: View {
        // MARK: - View
        var body: some View {
            configuration.label
        }
        
        // MARK: - Property
        private let configuration: CSUTextFieldStyleConfiguration
        
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
