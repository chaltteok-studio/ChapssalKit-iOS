//
//  View+CSUImageLabel.swift
//  
//
//  Created by JSilver on 2023/03/05.
//

import SwiftUI

public extension EnvironmentValues {
    var csuImageLabel: CSUImageLabel.Configuration {
        get { self[CSUImageLabel.ConfigurationKey.self] }
        set { self[CSUImageLabel.ConfigurationKey.self] = newValue }
    }
}

public extension View {
    func csuImageLabel<Value>(
        _ keyPath: WritableKeyPath<CSUImageLabel.Configuration, Value>,
        _ value: Value
    ) -> some View {
        let origin = \EnvironmentValues.csuImageLabel
        return environment(origin.appending(path: keyPath), value)
    }
}
