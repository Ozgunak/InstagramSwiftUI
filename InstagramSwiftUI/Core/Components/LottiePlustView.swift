//
//  LottiePlusView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-26.
//

import SwiftUI
import Lottie


struct LottiePlusView: UIViewRepresentable {
    let name: LottieName
    let loopMode: LottieLoopMode
    let animationSpeed: CGFloat
    
    let animationView: LottieAnimationView
    
    init(name: LottieName, loopMode: LottieLoopMode = .playOnce, animationSpeed: CGFloat = 1) {
        self.name = name
        self.loopMode = loopMode
        self.animationSpeed = animationSpeed
        self.animationView = LottieAnimationView(name: name.rawValue)
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        animationView.loopMode = loopMode
        animationView.animationSpeed = animationSpeed
        animationView.play()
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
        
    
}
