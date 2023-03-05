//
//  Resource+Font.swift
//  
//
//  Created by JSilver on 2021/06/06.
//

import UIKit

public extension R {
    enum Font { }
}

public extension R.Font {
    static func font(ofSize fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        .systemFont(ofSize: fontSize, weight: weight)
    }
}
