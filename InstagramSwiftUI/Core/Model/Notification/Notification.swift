//
//  Notification.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-27.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Notification: Identifiable, Hashable, Codable {
    @DocumentID var id: String?
    var fromUid: String
    var toId: String
    var fromName: String
    var notificationText: String
    var timeStamp: Timestamp
    
    var dictionary: [String: Any] {
        return ["fromUid": fromUid, "toId": toId, "fromName": fromName, "notificationText": notificationText, "timeStamp": timeStamp]
    }
}
extension Notification {
    static var MOCK_NOTIFICATION: Notification = Notification(fromUid: "RyBNzroloScxW6JMfYsmtAtFxVm1", toId: "Bt4sYd1cfwcOUzdvq3DnNVzycQJ2", fromName: "Ali", notificationText: "Hello", timeStamp: Timestamp())

}

enum NotificationType {
    case like(name: String)
    case follow
    case message(name: String)
    case comment
    
    var value: String {
        switch self {
        case .like(let name):
            "'\(name)' liked your post."
        case .follow:
            "You have new follower."
        case .message(let name):
            "You have got a new message from '\(name)'."
        case .comment:
            "You have new comment"
        }
    }
}
