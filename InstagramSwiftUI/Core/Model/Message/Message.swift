//
//  Message.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-27.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Message: Identifiable, Hashable, Codable {
    @DocumentID var id: String?
    var messageId: String
    var ownerUid: String
    var messageWithId: String
    var messageText: String
    var timeStamp: Timestamp
    
    var dictionary: [String: Any] {
        return ["messageId": messageId, "ownerUid": ownerUid, "messageWithId": messageWithId, "messageText": messageText, "timeStamp": timeStamp]
    }
}

