//
//  UserProfileView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-23.
//

import SwiftUI

struct UserProfileView: View {
    @StateObject var viewModel: UserProfileViewModel
    @State private var isPresented: Bool = false

    init(user: User) {
        self._viewModel = StateObject(wrappedValue: UserProfileViewModel(user: user))
    }
    
    
    var body: some View {
        
            ScrollView {
                VStack {

                    ProfileHeaderView(user: viewModel.user, postCount: viewModel.posts.count)
                    
                    actionButton
                    
                    PostGridView(posts: viewModel.posts, isLoading: viewModel.isLoading)
                    
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
                Task { try await viewModel.fetchUser() }
            } content: {
                EditProfileView(user: viewModel.user)
            }
            .task {
                do {
                    try await viewModel.fetchUserPosts()
                } catch {
                    print("Error: fetcing posts \(error.localizedDescription)")
                }
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
