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
    var joinDate: Timestamp? = Timestamp()
    var followers: [String]?
    var following: [String]?
    
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        return currentUid == id
    }
}

extension User {
    static var MOCK_USERS: [User] = [
        User(id: UUID().uuidString, username: "First City", profileImageURL: nil, fullName: "First City", bio: "first", email: "first.com"),
        User(id: UUID().uuidString, username: "second City", profileImageURL: nil, fullName: "second City", bio: "second", email: "second.com"),
        User(id: UUID().uuidString, username: "third City", profileImageURL: nil, fullName: "third City", bio: "third", email: "third.com"),
        User(id: UUID().uuidString, username: "fourth City", profileImageURL: nil, fullName: "fourth City", bio: "fourth", email: "fourth.com"),
        User(id: UUID().uuidString, username: "fifth City", profileImageURL: nil, fullName: "fifth City", bio: "fifth", email: "fifth.com")
    ]
}
