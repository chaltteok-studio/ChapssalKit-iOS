//
//  View+CSUTextField.swift
//  
//
//  Created by JSilver on 2023/03/04.
//

import SwiftUI

public extension EnvironmentValues {
    var csuTextField: CSUTextField.Configuration {
        get { self[CSUTextField.ConfigurationKey.self] }
        set { self[CSUTextField.ConfigurationKey.self] = newValue }
    }
}

public extension View {
    func csuTextField<Value>(
        _ keyPath: WritableKeyPath<CSUTextField.Configuration, Value>,
        _ value: Value
    ) -> some View {
        let origin = \EnvironmentValues.csuTextField
        return environment(origin.appending(path: keyPath), value)
    }
}
