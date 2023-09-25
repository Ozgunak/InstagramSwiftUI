//
//  ProfileView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-18.
//

import SwiftUI

struct ProfileView: View {
    let user: User

    var body: some View {
        
        ScrollView {
            VStack {
                
                ProfileHeaderView(user: user)
                
                actionButton
                
                PostGridView(user: user)
                
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button("SignOut") {
                        AuthService.shared.signout()
                    }
                } label: {
                    Image(systemName: "line.3.horizontal")
                }
            }
        }
        
        
    }
}

extension ProfileView {
    var actionButton: some View {
        Button {
            // TODO: add like func
        } label: {
            Text("Follow")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: 360, height: 32)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.rect(cornerRadius: 6))
                .overlay(RoundedRectangle(cornerRadius: 6).stroke(.gray, lineWidth: 1))
        }
    }
}

#Preview {
    ProfileView(user: User.MOCK_USERS.first!)
}
