//
//  AnimationView.swift
//  
//
//  Created by JSilver on 2023/02/20.
//

import SwiftUI
import Lottie

public struct AnimationView: UIViewRepresentable {
    // MARK: - Property
    var animation: LottieAnimation
    var backgroundBehavior: LottieBackgroundBehavior
    var loopMode: LottieLoopMode
    var isLoading: Bool = false
    
    // MARK: - Initializer
    init(
        animation: LottieAnimation,
        loopMode: LottieLoopMode = .playOnce,
        backgroundBehavior: LottieBackgroundBehavior = .pauseAndRestore
    ) {
        self.animation = animation
        self.loopMode = loopMode
        self.backgroundBehavior = backgroundBehavior
    }
    
    // MARK: - Lifecycle
    public func makeUIView(context: Context) -> LottieAnimationView {
        let view = LottieAnimationView()
        
        return view
    }
    
    public func updateUIView(_ uiView: LottieAnimationView, context: Context) {
        uiView.animation = animation
        uiView.backgroundBehavior = backgroundBehavior
        uiView.loopMode = loopMode
        isLoading ? uiView.play() : uiView.stop()
    }
    
    // MARK: - Public
    public func loading(_ isLoading: Bool) -> Self {
        var view = self
        view.isLoading = isLoading
        return view
    }
    
    // MARK: - Private
}
