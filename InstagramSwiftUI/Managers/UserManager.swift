//
//  UserManager.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-23.
//

import Foundation
import Firebase

class UserManager {
   
    private static let userCollectionRef = Firestore.firestore().collection("users")
    static func getUser(userID: String) async throws -> User {
        return try await userCollectionRef.document(userID).getDocument(as: User.self)
    }
    
    @MainActor
    static func fetchAllUsers() async throws -> [User] {
        let snapshot = try await userCollectionRef.getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: User.self)})
    }
    
    static func follow(followingUserId: String, followedId: String) async throws {
        try await userCollectionRef.document(followingUserId).updateData([
            "following": FieldValue.arrayUnion([followedId])
        ])
        try await userCollectionRef.document(followedId).updateData([
            "followers": FieldValue.arrayUnion([followingUserId])
        ])
    }
    
    static func unfollow(followingUserId: String, followedId: String) async throws {
        try await userCollectionRef.document(followingUserId).updateData([
            "following": FieldValue.arrayRemove([followedId])
        ])
        try await userCollectionRef.document(followedId).updateData([
            "followers": FieldValue.arrayRemove([followingUserId])
        ])
    }
    
    
//    static func fetchFollowers(for userId: String) async throws -> [User] {
//        let snapshot = try await userCollectionRef.whereField("following", arrayContains: userId).getDocuments()
//        return snapshot.documents.compactMap( { try $0.data(as: User.self) } )
//    }
}
