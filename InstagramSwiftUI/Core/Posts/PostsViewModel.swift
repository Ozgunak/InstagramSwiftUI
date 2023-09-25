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
    
    init(user: User?, post: Post) {
        self.user = user
        self.post = post
    }
}
