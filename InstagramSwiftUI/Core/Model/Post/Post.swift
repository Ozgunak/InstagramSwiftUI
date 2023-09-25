//
//  Post.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-24.
//

import Foundation
import Firebase

struct Post: Identifiable, Hashable, Codable {
    let id: String
    var ownerUid: String
    var caption: String
    var likes: Int
    var imageURL: String
    var timeStamp: Timestamp
    var user: User?
}

extension Post {
    static var MOCK_POST: Post = Post(id: "USMVDXlqjAjBl2OIqtCp", ownerUid: "xXmosFckXJeQZn8pyHTxDSKmuB73", caption: "123", likes: 0, imageURL: "https://firebasestorage.googleapis.com:443/v0/b/instagramswiftui-df1ee.appspot.com/o/postImages%2FED5DF7E4-1221-4B06-AD7A-A78B9712E00D?alt=media&token=5d63bc44-17a7-422e-81fd-4ca8ce2d31bb", timeStamp: Timestamp(), user: Optional(InstagramSwiftUI.User(id: "xXmosFckXJeQZn8pyHTxDSKmuB73", username: "oz", profileImageURL: Optional("https://firebasestorage.googleapis.com:443/v0/b/instagramswiftui-df1ee.appspot.com/o/profileImages%2F58F006FF-2F3C-4B6E-9294-495EDF5FBE00?alt=media&token=fdf9cc27-ac7a-4c90-a743-5e08ef223c39"), fullName: Optional("Ozgun Ak"), bio: Optional("iOS"), email: "1@2.com", joinDate: nil, followers: Optional(["2IoptF5NE5bYFJyxzWSJXXeGz762"]), following: Optional(["2IoptF5NE5bYFJyxzWSJXXeGz762", "H0vHXan5MjZUqpPSf5ppg7YKzwJ3"]))))
    
    static var MOCK_POSTS: [Post] = [
        Post(id: "53uczCtYgMoTJMXiI2ao", ownerUid: "xXmosFckXJeQZn8pyHTxDSKmuB73", caption: "Ll", likes: 0, imageURL: "https://firebasestorage.googleapis.com:443/v0/b/instagramswiftui-df1ee.appspot.com/o/postImages%2F285AF372-334F-46BE-A833-B51A4B4AA029?alt=media&token=0df70062-169f-4011-b53a-ae22335c153f", timeStamp: Timestamp(), user: Optional(InstagramSwiftUI.User(id: "xXmosFckXJeQZn8pyHTxDSKmuB73", username: "oz", profileImageURL: Optional("https://firebasestorage.googleapis.com:443/v0/b/instagramswiftui-df1ee.appspot.com/o/profileImages%2F58F006FF-2F3C-4B6E-9294-495EDF5FBE00?alt=media&token=fdf9cc27-ac7a-4c90-a743-5e08ef223c39"), fullName: Optional("Ozgun Ak"), bio: Optional("iOS"), email: "1@2.com", joinDate: nil, followers: Optional(["2IoptF5NE5bYFJyxzWSJXXeGz762"]), following: Optional(["2IoptF5NE5bYFJyxzWSJXXeGz762", "H0vHXan5MjZUqpPSf5ppg7YKzwJ3"])))),
        Post(id: "USMVDXlqjAjBl2OIqtCp", ownerUid: "xXmosFckXJeQZn8pyHTxDSKmuB73", caption: "123", likes: 0, imageURL: "https://firebasestorage.googleapis.com:443/v0/b/instagramswiftui-df1ee.appspot.com/o/postImages%2FED5DF7E4-1221-4B06-AD7A-A78B9712E00D?alt=media&token=5d63bc44-17a7-422e-81fd-4ca8ce2d31bb", timeStamp: Timestamp(), user: Optional(InstagramSwiftUI.User(id: "xXmosFckXJeQZn8pyHTxDSKmuB73", username: "oz", profileImageURL: Optional("https://firebasestorage.googleapis.com:443/v0/b/instagramswiftui-df1ee.appspot.com/o/profileImages%2F58F006FF-2F3C-4B6E-9294-495EDF5FBE00?alt=media&token=fdf9cc27-ac7a-4c90-a743-5e08ef223c39"), fullName: Optional("Ozgun Ak"), bio: Optional("iOS"), email: "1@2.com", joinDate: nil, followers: Optional(["2IoptF5NE5bYFJyxzWSJXXeGz762"]), following: Optional(["2IoptF5NE5bYFJyxzWSJXXeGz762", "H0vHXan5MjZUqpPSf5ppg7YKzwJ3"]))))
    ]
}
