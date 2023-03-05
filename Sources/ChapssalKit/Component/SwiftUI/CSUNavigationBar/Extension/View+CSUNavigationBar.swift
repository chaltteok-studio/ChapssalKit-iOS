//
//  View+CSUNavigationBar.swift
//  
//
//  Created by JSilver on 2023/03/05.
//

import SwiftUI

public extension EnvironmentValues {
    var csuNavigationBar: CSUNavigationBar.Configuration {
        get { self[CSUNavigationBar.ConfigurationKey.self] }
        set { self[CSUNavigationBar.ConfigurationKey.self] = newValue }
    }
}

public extension View {
    func csuNavigationBar<Value>(
        _ keyPath: WritableKeyPath<CSUNavigationBar.Configuration, Value>,
        _ value: Value
    ) -> some View {
        let origin = \EnvironmentValues.csuNavigationBar
        return environment(origin.appending(path: keyPath), value)
    }
}
