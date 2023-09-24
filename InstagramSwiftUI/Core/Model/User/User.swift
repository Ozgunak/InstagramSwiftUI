//
//  User.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-23.
//

import Foundation
import Firebase

struct User: Identifiable, Hashable, Codable {
    let id: String
    var username: String
    var profileImageURL: String?
    var fullName: String?
    var bio: String?
    let email: String
    
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        return currentUid == id
    }
}

extension User {
    static var MOCK_USERS: [User] = [
        User(id: UUID().uuidString, username: "First City", profileImageURL: "pimage1", fullName: "First City", bio: "first", email: "first.com"),
        User(id: UUID().uuidString, username: "second City", profileImageURL: "city2", fullName: "second City", bio: "second", email: "second.com"),
        User(id: UUID().uuidString, username: "third City", profileImageURL: "city3", fullName: "third City", bio: "third", email: "third.com"),
        User(id: UUID().uuidString, username: "fourth City", profileImageURL: "city4", fullName: "fourth City", bio: "fourth", email: "fourth.com"),
        User(id: UUID().uuidString, username: "fifth City", profileImageURL: "city5", fullName: "fifth City", bio: "fifth", email: "fifth.com")
    ]
}
