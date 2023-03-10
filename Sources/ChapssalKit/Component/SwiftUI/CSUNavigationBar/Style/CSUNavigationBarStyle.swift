//
//  CSUNavigationBarStyle.swift
//  
//
//  Created by JSilver on 2023/03/11.
//

import SwiftUI

public protocol CSUNavigationBarStyle {
    associatedtype Body: View
    typealias Configuration = CSUNavigationBarStyleConfiguration
    
    func makeBody(_ configuration: Configuration) -> Body
}

public extension CSUNavigationBarStyle where Self == CSUPlainNavigationBarStyle {
    static var plain: Self { CSUPlainNavigationBarStyle() }
}

public struct CSUNavigationBarStyleConfiguration {
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

public struct CSUPlainNavigationBarStyle: CSUNavigationBarStyle {
    private struct Content: View {
        // MARK: - View
        var body: some View {
            configuration.label
        }
        
        // MARK: - Property
        let configuration: CSUNavigationBarStyleConfiguration
        
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
