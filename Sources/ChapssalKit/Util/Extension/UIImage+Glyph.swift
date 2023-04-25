//
//  UIImage+Glyph.swift
//  
//
//  Created by JSilver on 2021/06/09.
//

import UIKit

public extension UIImage {
    var glyph: UIImage {
        withRenderingMode(.alwaysTemplate)
    }
}
