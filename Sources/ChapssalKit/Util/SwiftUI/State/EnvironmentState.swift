//
//  EnvironmentState.swift
//  
//
//  Created by JSilver on 2023/03/04.
//

import SwiftUI

@propertyWrapper
public struct EnvironmentState<T>: DynamicProperty {
    // MARK: - Property
    private let state: State<T>
    @Environment
    private var environment: Binding<T>?
    
    public var wrappedValue: T {
        get {
            projectedValue.wrappedValue
        }
        nonmutating set {
            projectedValue.wrappedValue = newValue
        }
    }
    
    public var projectedValue: Binding<T> {
        environment ?? state.projectedValue
    }
    
    // MARK: - Initializer
    public init(
        wrappedValue: T,
        _ keyPath: KeyPath<EnvironmentValues, Binding<T>?>
    ) {
        self.state = .init(initialValue: wrappedValue)
        self._environment = .init(keyPath)
    }
    
    // MARK: - Public
    
    // MARK: - Private
}
