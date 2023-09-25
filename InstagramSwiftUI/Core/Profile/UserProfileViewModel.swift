//
//  UserProfileViewModel.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-25.
//

import Foundation

@MainActor
class UserProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var posts = [Post]()
    @Published var isLoading: Bool = false
    init(user: User) {
        self.user = user
    }
    
    func fetchUserPosts() async throws {
        isLoading = true
        self.posts = try await PostManager.fetchUserPost(userId: user.id)
        
        for i in 0 ..< posts.count {
            posts[i].user = self.user
        }
        isLoading = false
    }
}
