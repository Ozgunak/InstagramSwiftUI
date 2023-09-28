//
//  NotificationManager.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-27.
//

import Foundation
import Firebase

struct NotificationManager {
    static private var notificationRef = Firestore.firestore().collection("notifications")
    
    static func fetchNotifications(for userId: String, completion: @escaping ([Notification]) -> Void ) {
        let doc = notificationRef.document()
        
        notificationRef.whereField("toId", isEqualTo: userId).addSnapshotListener { snap, error in
            if let snap {
                let notificatios = snap.documents.compactMap({ try? $0.data(as: Notification.self) })
                completion(notificatios)
            }
        }
        
    }
    
    static func addNotification(notification: Notification) async throws {
        try await notificationRef.addDocument(data: notification.dictionary)
    }
}

