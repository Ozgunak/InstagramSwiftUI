//
//  PostManager.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-24.
//

import Foundation
import Firebase

struct PostManager {
    static func fetchHomeFeedPosts() async throws -> [Post] {
        let snapshot = try await Firestore.firestore().collection("posts").order(by: "timeStamp", descending: true).getDocuments()
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
        let snapshot = try await Firestore.firestore().collection("posts").whereField("ownerUid", isEqualTo: userId).getDocuments()

        return snapshot.documents.compactMap({ try? $0.data(as: Post.self) }).sorted(by: { $0.timeStamp.seconds > $1.timeStamp.seconds } )
    }
}
