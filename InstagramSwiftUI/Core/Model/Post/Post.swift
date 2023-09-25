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
    var likes: [String]
    var imageURL: String
    var timeStamp: Timestamp
    var user: User?
}

extension Post {
    static var MOCK_POST: Post = Post(id: "BSvHfdpYFU055q3DiWlw", ownerUid: "xXmosFckXJeQZn8pyHTxDSKmuB73", caption: "First", likes: ["xXmosFckXJeQZn8pyHTxDSKmuB73"], imageURL: "https://firebasestorage.googleapis.com:443/v0/b/instagramswiftui-df1ee.appspot.com/o/postImages%2F9CD6EB9D-802A-4524-98BE-95A0F61C65C7?alt=media&token=533bbecd-e5dc-4899-b91e-0cf1af712219", timeStamp: Timestamp(), user: Optional(InstagramSwiftUI.User(id: "xXmosFckXJeQZn8pyHTxDSKmuB73", username: "oz", profileImageURL: Optional("https://firebasestorage.googleapis.com:443/v0/b/instagramswiftui-df1ee.appspot.com/o/profileImages%2F58F006FF-2F3C-4B6E-9294-495EDF5FBE00?alt=media&token=fdf9cc27-ac7a-4c90-a743-5e08ef223c39"), fullName: Optional("Ozgun Ak"), bio: Optional("iOS"), email: "1@2.com", joinDate: nil, followers: Optional(["2IoptF5NE5bYFJyxzWSJXXeGz762"]), following: Optional(["2IoptF5NE5bYFJyxzWSJXXeGz762", "H0vHXan5MjZUqpPSf5ppg7YKzwJ3"]))))
    
    static var MOCK_POSTS: [Post] = [
        Post(id: "znjuNYlfdx27miCkgjod", ownerUid: "xXmosFckXJeQZn8pyHTxDSKmuB73", caption: "3", likes: ["xXmosFckXJeQZn8pyHTxDSKmuB73"], imageURL: "https://firebasestorage.googleapis.com:443/v0/b/instagramswiftui-df1ee.appspot.com/o/postImages%2F67596E23-8FDC-4264-8205-021D3F8E980D?alt=media&token=b92ec151-9864-4253-a971-3186fa221909", timeStamp: Timestamp(), user: Optional(InstagramSwiftUI.User(id: "xXmosFckXJeQZn8pyHTxDSKmuB73", username: "oz", profileImageURL: Optional("https://firebasestorage.googleapis.com:443/v0/b/instagramswiftui-df1ee.appspot.com/o/profileImages%2F58F006FF-2F3C-4B6E-9294-495EDF5FBE00?alt=media&token=fdf9cc27-ac7a-4c90-a743-5e08ef223c39"), fullName: Optional("Ozgun Ak"), bio: Optional("iOS"), email: "1@2.com", joinDate: nil, followers: Optional(["2IoptF5NE5bYFJyxzWSJXXeGz762"]), following: Optional(["2IoptF5NE5bYFJyxzWSJXXeGz762", "H0vHXan5MjZUqpPSf5ppg7YKzwJ3"])))),
        Post(id: "ML3Svpca8h1jWMMQJ5uG", ownerUid: "xXmosFckXJeQZn8pyHTxDSKmuB73", caption: "2", likes: [], imageURL: "https://firebasestorage.googleapis.com:443/v0/b/instagramswiftui-df1ee.appspot.com/o/postImages%2F74173944-1842-4BCC-9123-1DDB85C02245?alt=media&token=ef6e627a-866d-4e3a-9c69-8873a5a59762", timeStamp: Timestamp(), user: Optional(InstagramSwiftUI.User(id: "xXmosFckXJeQZn8pyHTxDSKmuB73", username: "oz", profileImageURL: Optional("https://firebasestorage.googleapis.com:443/v0/b/instagramswiftui-df1ee.appspot.com/o/profileImages%2F58F006FF-2F3C-4B6E-9294-495EDF5FBE00?alt=media&token=fdf9cc27-ac7a-4c90-a743-5e08ef223c39"), fullName: Optional("Ozgun Ak"), bio: Optional("iOS"), email: "1@2.com", joinDate: nil, followers: Optional(["2IoptF5NE5bYFJyxzWSJXXeGz762"]), following: Optional(["2IoptF5NE5bYFJyxzWSJXXeGz762", "H0vHXan5MjZUqpPSf5ppg7YKzwJ3"])))),
        Post(id: "BSvHfdpYFU055q3DiWlw", ownerUid: "xXmosFckXJeQZn8pyHTxDSKmuB73", caption: "First", likes: ["xXmosFckXJeQZn8pyHTxDSKmuB73"], imageURL: "https://firebasestorage.googleapis.com:443/v0/b/instagramswiftui-df1ee.appspot.com/o/postImages%2F9CD6EB9D-802A-4524-98BE-95A0F61C65C7?alt=media&token=533bbecd-e5dc-4899-b91e-0cf1af712219", timeStamp: Timestamp(), user: Optional(InstagramSwiftUI.User(id: "xXmosFckXJeQZn8pyHTxDSKmuB73", username: "oz", profileImageURL: Optional("https://firebasestorage.googleapis.com:443/v0/b/instagramswiftui-df1ee.appspot.com/o/profileImages%2F58F006FF-2F3C-4B6E-9294-495EDF5FBE00?alt=media&token=fdf9cc27-ac7a-4c90-a743-5e08ef223c39"), fullName: Optional("Ozgun Ak"), bio: Optional("iOS"), email: "1@2.com", joinDate: nil, followers: Optional(["2IoptF5NE5bYFJyxzWSJXXeGz762"]), following: Optional(["2IoptF5NE5bYFJyxzWSJXXeGz762", "H0vHXan5MjZUqpPSf5ppg7YKzwJ3"]))))
        
    ]
}
