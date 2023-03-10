//
//  UIImage+Load.swift
//  
//
//  Created by JSilver on 2023/03/09.
//

import UIKit

extension UIImage {
    static func load(named: String, in bundle: Bundle? = nil) -> UIImage? {
        .init(named: named, in: bundle ?? .module, compatibleWith: nil)
    }
}
