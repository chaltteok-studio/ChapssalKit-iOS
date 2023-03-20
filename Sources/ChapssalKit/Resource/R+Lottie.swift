//
//  R+Lottie.swift
//  
//
//  Created by JSilver on 2021/10/11.
//

import Foundation
import Lottie

public extension R {
    enum Lottie { }
}

public extension R.Lottie {
    static var loadingGray: LottieAnimation { LottieAnimation.named("loading_gray", bundle: .module)! }
    static var loadingWhite: LottieAnimation { LottieAnimation.named("loading_white", bundle: .module)! }
    static var loadingGreen: LottieAnimation { LottieAnimation.named("loading_green", bundle: .module)! }
}
