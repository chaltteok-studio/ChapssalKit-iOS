//
//  String+Localized.swift
//  
//
//  Created by JSilver on 2021/05/29.
//

import Foundation

public extension String {
    var localized: String {
        NSLocalizedString(self, bundle: .module, comment: "")
    }
}
