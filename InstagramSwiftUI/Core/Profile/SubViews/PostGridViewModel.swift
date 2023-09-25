//
//  PostGridViewModel.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-24.
//

import Foundation

@MainActor
class PostGridViewModel: ObservableObject {
    @Published var posts = [Post]()
    private let user: User
    
    init(user: User) {
        self.user = user
        
        Task { try await fetchUserPosts() }
    }
    
    @MainActor
    func fetchUserPosts() async throws {
        self.posts = try await PostManager.fetchUserPost(userId: user.id)
        
        for i in 0 ..< posts.count {
            posts[i].user = self.user
        }
    }
}
