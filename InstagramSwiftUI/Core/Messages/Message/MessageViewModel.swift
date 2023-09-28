//
//  MessageViewModel.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-28.
//

import Foundation
import Firebase

@MainActor
class MessageViewModel: ObservableObject {
    @Published var user: User?
    @Published var messages: [Message] = []
    @Published var messageText: String = ""
    @Published var messanger: User?
    
    init(messanger: User) {
        self.messanger = messanger
        Task { try await getUserMessages() }
    }
    
    func getUserMessages() async throws {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        user = try await UserManager.getUser(userID: userId)
        // get messages
        if let messanger = messanger {
            MessageManager.fetchMessage(userId: userId, messangerId: messanger.id, completion: { messages in
                self.messages = messages
            })
        }
    }
    
    func addMessage() async throws {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        try await MessageManager.addMessage(message: Message(messageId: UUID().uuidString,
                                                          ownerUid: userId,
                                                          messageWithId: messanger?.id ?? "",
                                                          messageText: messageText,
                                                          timeStamp: Timestamp()))
        if let messanger {
            let notification = Notification(fromUid: userId,
                                            toId: messanger.id,
                                            fromName: messanger.fullName ?? messanger.username,
                                            notificationText: NotificationType.message(name: messanger.fullName ?? messanger.username).value,
                                            timeStamp: Timestamp())
            try await NotificationManager.addNotification(notification: notification)
        }
    }
}
