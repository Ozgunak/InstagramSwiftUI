//
//  Comment.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-25.
//

import Foundation
import Firebase

struct Comment: Identifiable, Hashable, Codable {
    let id: String
    var ownerUid: String
    var text: String
    var postId: String
    var timeStamp: Timestamp
    var user: User?
    
    var dictionary: [String: Any] {
        return ["id": id, "ownerUid": ownerUid, "text": text, "postId": postId, "timeStamp": timeStamp]
    }
}
