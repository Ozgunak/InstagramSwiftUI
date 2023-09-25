//
//  ProfileView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-18.
//

import SwiftUI


struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel

    init(user: User) {
        self._viewModel = StateObject(wrappedValue: ProfileViewModel(user: user))        
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
        .task {
            do {
                try await viewModel.fetchUserPosts()
            } catch {
                print("Error: fetching posts \(error.localizedDescription)")
            }
        }
        
        
    }
}

extension ProfileView {
    var actionButton: some View {
        Button {
            if viewModel.isFollowing() {
                Task {
                    do {
                        try await viewModel.unfollow()
                    } catch {
                        print("Error: unfollowing \(error.localizedDescription)")
                    }
                }
            } else {
                Task {
                    do {
                        try await viewModel.follow()
                        print("followed")
                    } catch {
                        print("Error: following \(error.localizedDescription)")
                    }
                }
            }
            
        } label: {
            Text(viewModel.isFollowing() ? "Unfollow" : "Follow")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: 360, height: 32)
                .background(viewModel.isFollowing() ? .white : .blue)
                .foregroundStyle(viewModel.isFollowing() ? .black : .white)
                .clipShape(.rect(cornerRadius: 6))
                .overlay(RoundedRectangle(cornerRadius: 6).stroke(.gray, lineWidth: 1))
        }
    }
}

#Preview {
    ProfileView(user: User.MOCK_USERS.first!)
}
