//
//  PostsViewModel.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-25.
//

import Foundation

@MainActor
class PostsViewModel: ObservableObject {
    @Published var post: Post
    @Published var user: User?
    @Published var comments: [Comment] = []
    
    init(user: User?, post: Post) {
        self.user = user
        self.post = post
    }
    
    func fetchComments() async throws {
        comments = try await PostManager.fetchComments(post: post)
    }
}
