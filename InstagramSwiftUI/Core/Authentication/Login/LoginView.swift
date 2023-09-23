//
//  LoginView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-21.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image("titleimage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 100)
                
                VStack {
                    TextField("Enter your email", text: $viewModel.email)
                        .textInputAutocapitalization(.never)
                        .modifier(IGTextFieldModifier())
                    SecureField("Enter your password", text: $viewModel.password)
                        .modifier(IGTextFieldModifier())
                }
                
                Button {
                 print("Forgot password")
                } label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing, 28)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Button {
                    Task {
                        try await viewModel.login()
                    }                    
                } label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 360, height: 44)
                        .background(.blue.gradient)
                        .clipShape(.rect(cornerRadius: 8))
                }
                .padding(.vertical)
                
                HStack {
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40 , height: 0.5)
                    
                    Text("OR")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40 , height: 0.5)
                }
                .foregroundStyle(.gray)
                
                HStack {
                    Image("facebook")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 32, height: 32)
                    
                    Button {} label: {
                        Text("Continue with Facebook")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                }
                Spacer()
                
                Divider()
                
                NavigationLink {
                    AddEmailView()
                        .navigationBarBackButtonHidden()
                } label: {
                    Group {
                        Text("Don't have an account? ") +
                        Text("Sign Up")
                        .fontWeight(.semibold)
                    }            
                    .font(.subheadline)
                }
                .padding(.bottom)
            }
        }
    }
}

#Preview {
    LoginView()
}
