//
//  HomeViewModel.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-24.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var posts: [Post] = []
    
    func fetchPosts() async throws {
        posts = try await PostManager.fetchHomeFeedPosts()
    }
}
