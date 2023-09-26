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
    let contentMode: UIView.ContentMode
    let animationView: LottieAnimationView
    @Binding var play: Bool
    
    init(name: LottieName, 
         loopMode: LottieLoopMode = .playOnce,
         animationSpeed: CGFloat = 1,
         contentMode: UIView.ContentMode = .scaleAspectFit,
         play: Binding<Bool> = .constant(true)) {
        self.name = name
        self.loopMode = loopMode
        self.animationSpeed = animationSpeed
        self.animationView = LottieAnimationView(name: name.rawValue)
        self.contentMode = contentMode
        self._play = play
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        animationView.loopMode = loopMode
        animationView.animationSpeed = animationSpeed
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if play {
            animationView.play { completed in
                print("lottie status: \(completed)")
                play = false
            }
        }

    }
        
    
}
