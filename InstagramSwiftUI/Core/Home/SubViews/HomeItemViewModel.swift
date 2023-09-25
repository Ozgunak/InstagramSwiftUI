//
//  HomeItemViewModel.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-25.
//

import Foundation
import Firebase

@MainActor
class HomeItemViewModel: ObservableObject {
    @Published var post: Post
    let currentUserId = Auth.auth().currentUser?.uid

    var isLiked: Bool {
        if let currentUserId {
            return post.likes.contains(currentUserId)
        } else {
            return false
        }
    }
    
    init(post: Post) {
        self.post = post
    }
    
    func like() async throws {
            try await PostManager.likePost(post: post)
            if let currentUserId {
                post.likes.append(currentUserId)
            }
    }
    
    func unlike() async throws {
         try await PostManager.unlikePost(post: post)
        if let currentUserId {
            post.likes.removeAll(where: { $0.contains(currentUserId) } )
        }
    }

}
