//
//  UserManager.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-23.
//

import Foundation
import Firebase

class UserManager {
   
    static func getUser(userID: String) async throws -> User {
        return try await Firestore.firestore().collection("users").document(userID).getDocument(as: User.self)
    }
    
    @MainActor
    static func fetchAllUsers() async throws -> [User] {
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: User.self)})
    }
}
