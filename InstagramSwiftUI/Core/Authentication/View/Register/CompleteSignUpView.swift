//
//  CompleteSignUpView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-21.
//

import SwiftUI

struct CompleteSignUpView: View {
    @EnvironmentObject var viewModel: RegistrationViewModel

    var body: some View {
        VStack(spacing: 12) {
            Text("Welcome to Instagram, \(viewModel.username)")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            
            Text("Click below to complete registration and start using Instagram")
                .font(.footnote)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            
            Button {
                Task { try await viewModel.createUser() }
            } label: {
                Text("Complete Sign Up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 360, height: 44)
                    .background(.blue.gradient)
                    .clipShape(.rect(cornerRadius: 8))
            }
            .padding(.vertical)
            
        }
        
    }
}

#Preview {
    CompleteSignUpView()
        .environmentObject(RegistrationViewModel())
}
