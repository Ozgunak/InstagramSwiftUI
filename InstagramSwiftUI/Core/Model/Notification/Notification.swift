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
    var notificationText: String
    var timeStamp: Timestamp
    
    var dictionary: [String: Any] {
        return ["fromUid": fromUid, "toId": toId, "notificationText": notificationText, "timeStamp": timeStamp]
    }
}
extension Notification {
    static var MOCK_NOTIFICATION: Notification = Notification(fromUid: "RyBNzroloScxW6JMfYsmtAtFxVm1", toId: "Bt4sYd1cfwcOUzdvq3DnNVzycQJ2", notificationText: "Hello", timeStamp: Timestamp())

}
