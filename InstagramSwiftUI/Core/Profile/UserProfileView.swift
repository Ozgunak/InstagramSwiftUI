//
//  UserProfileView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-23.
//

import SwiftUI

struct UserProfileView: View {
    let user: User
    @State private var isPresented: Bool = false

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
            .fullScreenCover(isPresented: $isPresented) {
//                TODO: update data
            } content: {
                EditProfileView(user: user)

            }
            

            
        
    }
}

extension UserProfileView {
    
    var actionButton: some View {
        Button(action: {
            isPresented.toggle()
        }, label: {
            Text("Edit Profile")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: 360, height: 32)
                .overlay(RoundedRectangle(cornerRadius: 6).stroke(.gray, lineWidth: 1))
        })
    }
    
    
}


#Preview {
    UserProfileView(user: User.MOCK_USERS.first!)
}
