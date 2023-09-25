//
//  PostManager.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-24.
//

import Foundation
import Firebase

struct PostManager {
    static private let postsCollectionPath = Firestore.firestore().collection("posts")
    static func fetchHomeFeedPosts() async throws -> [Post] {
        let snapshot = try await postsCollectionPath.order(by: "timeStamp", descending: true).getDocuments()
        var posts = snapshot.documents.compactMap( { try? $0.data(as: Post.self) })
        
        for i in 0 ..< posts.count {
            let post = posts[i]
            let ownerUid = post.ownerUid
            let postUser = try await UserManager.getUser(userID: ownerUid)
            posts[i].user = postUser
        }
        return posts
    }
    
    static func fetchUserPost(userId: String) async throws -> [Post] {
        let snapshot = try await postsCollectionPath.whereField("ownerUid", isEqualTo: userId).getDocuments()

        return snapshot.documents.compactMap({ try? $0.data(as: Post.self) }).sorted(by: { $0.timeStamp.seconds > $1.timeStamp.seconds } )
    }
    
    static func likePost(post: Post) async throws {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        try await postsCollectionPath.document(post.id).updateData([
            "likes": FieldValue.arrayUnion([userId])
        ])
    }
    static func unlikePost(post: Post) async throws {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        try await postsCollectionPath.document(post.id).updateData([
            "likes": FieldValue.arrayRemove([userId])
        ])
    }
}
