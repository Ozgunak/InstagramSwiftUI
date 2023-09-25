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
    
    static var MOCK_USER: User = User(id: "xXmosFckXJeQZn8pyHTxDSKmuB73", username: "oz", profileImageURL: Optional("https://firebasestorage.googleapis.com:443/v0/b/instagramswiftui-df1ee.appspot.com/o/profileImages%2F58F006FF-2F3C-4B6E-9294-495EDF5FBE00?alt=media&token=fdf9cc27-ac7a-4c90-a743-5e08ef223c39"), fullName: Optional("Ozgun Ak"), bio: Optional("iOS"), email: "1@2.com", joinDate: nil, followers: Optional(["2IoptF5NE5bYFJyxzWSJXXeGz762"]), following: Optional(["2IoptF5NE5bYFJyxzWSJXXeGz762", "H0vHXan5MjZUqpPSf5ppg7YKzwJ3"]))
}
