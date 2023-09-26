//
//  LoadingScreen.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-25.
//

import SwiftUI

struct LoadingScreen: View {
    @Binding var showLoading: Bool
    @State var animate = false

    var body: some View {
        ZStack {
            Color.clear
                .ignoresSafeArea()
                
            VStack {
                Circle()
                    .trim(from: 0, to: 0.8)
                    .stroke(AngularGradient.init(gradient: Gradient(colors: [Color.gray, Color.blue]), center: .center), style: StrokeStyle(lineWidth: 5, lineCap: .round))
                    .frame(width: 100, height: 100)
                    .rotationEffect(.degrees( animate ? 360 : 0))
                    .animation(.linear(duration: 0.7).repeatForever(autoreverses: false))
            }
            .padding(.horizontal, 100)
            .padding(.vertical, 200)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.ultraThickMaterial)
//            .clipShape(.rect(cornerRadius: 20))
            
            .onAppear {
                animate.toggle()
            }
        }
    }
}

#Preview {
    LoadingScreen(showLoading: .constant(true))
}
