//
//  LottieView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-26.
//

import SwiftUI
import Lottie

enum LottieName: String {
    case logoJump
    case like
    case loading
    case like2
}

struct LottieView: UIViewRepresentable {
    let name: LottieName
    let loopMode: LottieLoopMode
    
    init(name: LottieName, loopMode: LottieLoopMode = .playOnce) {
        self.name = name
        self.loopMode = loopMode
    }
    
    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: name.rawValue)
        animationView.loopMode = loopMode
        animationView.play()
        return animationView
    }
    
    func updateUIView(_ uiView: Lottie.LottieAnimationView, context: Context) {
        
    }
        
    
}
