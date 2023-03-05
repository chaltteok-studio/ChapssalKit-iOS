//
//  View+CSUButton.swift
//  
//
//  Created by JSilver on 2023/03/03.
//

import SwiftUI

public extension EnvironmentValues {
    var csuButton: CSUButton.Configuration {
        get { self[CSUButton.ConfigurationKey.self] }
        set { self[CSUButton.ConfigurationKey.self] = newValue }
    }
}

public extension View {
    func csuButton<Value>(
        _ keyPath: WritableKeyPath<CSUButton.Configuration, Value>,
        _ value: Value
    ) -> some View {
        let origin = \EnvironmentValues.csuButton
        return environment(origin.appending(path: keyPath), value)
    }
}
