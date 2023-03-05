//
//  Resource+Color.swift
//  
//
//  Created by JSilver on 2021/06/06.
//

import UIKit

public extension R {
    enum Color { }
}

public extension R.Color {
    // MARK: - Basic
    static var black: UIColor { .traitColor(.init(hex: 0x000000)) }
    static var white: UIColor { .traitColor(.init(hex: 0xFFFFFF)) }
    
    // MARK: - Gray Scale
    static var gray01: UIColor { .traitColor(.init(hex: 0x282828)) }
    static var gray02: UIColor { .traitColor(.init(hex: 0x727272)) }
    static var gray03: UIColor { .traitColor(.init(hex: 0x9A9A9A)) }
    static var gray04: UIColor { .traitColor(.init(hex: 0xCCCCCC)) }
    static var gray05: UIColor { .traitColor(.init(hex: 0xE2E2E2)) }
    static var gray06: UIColor { .traitColor(.init(hex: 0xF4F4F4)) }
    
    // MARK: - Primary
    static var green01: UIColor { .traitColor(.init(hex: 0x32C369)) }
    static var green02: UIColor { .traitColor(.init(hex: 0x0F582B)) }
    static var green03: UIColor { .traitColor(.init(hex: 0x177C3D)) }
    static var green04: UIColor { .traitColor(.init(hex: 0x0F582B)) }
    
    // MARK: - Secondary
    static var yellow01: UIColor { .traitColor(.init(hex: 0xFFC454)) }
    static var yellow02: UIColor { .traitColor(.init(hex: 0xFBE4A7)) }
    static var blue01: UIColor { .traitColor(.init(hex: 0x2CA8EE)) }
    static var red01: UIColor { .traitColor(.init(hex: 0xDD5050)) }
}
