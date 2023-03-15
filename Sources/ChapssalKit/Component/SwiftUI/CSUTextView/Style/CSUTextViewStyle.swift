//
//  CSUTextViewStyle.swift
//
//
//  Created by JSilver on 2023/03/11.
//

import SwiftUI

public protocol CSUTextViewStyle {
    associatedtype Body: View
    typealias Configuration = CSUTextViewStyleConfiguration
    
    func makeBody(_ configuration: Configuration) -> Body
}

public extension CSUTextViewStyle where Self == CSUPlainTextViewStyle {
    static var plain: Self { CSUPlainTextViewStyle() }
}

public extension CSUTextFieldStyle {
    
}

public struct CSUTextViewStyleConfiguration {
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

public struct CSUPlainTextViewStyle: CSUTextViewStyle {
    private struct Content: View {
        // MARK: - View
        var body: some View {
            configuration.label
        }
        
        // MARK: - Property
        let configuration: CSUTextViewStyleConfiguration
        
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
