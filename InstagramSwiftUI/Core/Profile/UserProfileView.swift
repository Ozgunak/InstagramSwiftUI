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

                    headerView
                    
                    actionButton
                    
                    PostGridView(user: user)
                    
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Text("")
                        Text("")
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
    var headerView: some View {
        VStack {
            HStack(spacing: 30){
                IGCircularProfileImageView(user: user)
                Spacer()
                ProfileStatsView(count: 13, title: "Posts")
                ProfileStatsView(count: 100, title: "Followers")
                ProfileStatsView(count: 134, title: "Following")
            }
            .padding(.horizontal)


            
            VStack(alignment: .leading ) {
                Text(user.fullName ?? "")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text(user.bio ?? "")
                    .font(.subheadline)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
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
