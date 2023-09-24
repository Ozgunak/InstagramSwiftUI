//
//  Post.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-24.
//

import Foundation

struct Post: Identifiable, Hashable, Codable {
    let id: String
    var ownerUid: String
    var caption: String
    var likes: Int
    var imageURL: String
    var timeStamp: Date
    var user: User?
}
