//
//  ArrayBuilder.swift
//  
//
//  Created by JSilver on 2023/02/22.
//

import Foundation

@resultBuilder
struct ArrayBuilder<Element> {
    static func run(@ArrayBuilder<Element> _ block: () -> [Element]) -> [Element] {
        block()
    }
    
    static func buildBlock(_ components: Element...) -> [Element] {
        return components
    }
    
    static func buildArray(_ components: [[Element]]) -> [Element] {
        return components.flatMap { $0 }
    }
    
    static func buildOptional(_ component: [Element]?) -> [Element] {
        return component ?? []
    }
    
    static func buildEither(first component: [Element]) -> [Element] {
        return component
    }
    
    static func buildEither(second component: [Element]) -> [Element] {
        return component
    }
    
    static func buildIf(_ element: [Element]?) -> [Element] {
        element ?? []
    }
    
    static func buildPartialBlock(first: Element) -> [Element] {
        [first]
    }
    
    static func buildPartialBlock(first: [Element]) -> [Element] {
        first
    }
    
    static func buildPartialBlock(accumulated: [Element], next: Element) -> [Element] {
        accumulated + [next]
    }
    
    static func buildPartialBlock(accumulated: [Element], next: [Element]) -> [Element] {
        accumulated + next
    }
}
