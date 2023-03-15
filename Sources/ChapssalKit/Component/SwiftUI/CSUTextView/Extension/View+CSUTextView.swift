//
//  View+CSUTextView.swift
//
//
//  Created by JSilver on 2023/03/04.
//

import SwiftUI

public extension EnvironmentValues {
    var csuTextView: CSUTextView.Configuration {
        get { self[CSUTextView.ConfigurationKey.self] }
        set { self[CSUTextView.ConfigurationKey.self] = newValue }
    }
}

public extension View {
    func csuTextView<Value>(
        _ keyPath: WritableKeyPath<CSUTextView.Configuration, Value>,
        _ value: Value
    ) -> some View {
        let origin = \EnvironmentValues.csuTextView
        return environment(origin.appending(path: keyPath), value)
    }
}
