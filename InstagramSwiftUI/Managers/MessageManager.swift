//
//  MessageManager.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-27.
//

import Foundation
import Firebase

struct MessageManager {
    
    static private let messageRef = Firestore.firestore().collection("messages")
    static func addMessage(message: Message) async throws {
        let _ = try await messageRef.document(message.ownerUid).collection(message.messageWithId).addDocument(data: message.dictionary)
        let _ = try await messageRef.document(message.messageWithId).collection(message.ownerUid).addDocument(data: message.dictionary)
    }
    
    static func fetchMessage(userId: String, messangerId: String, completion: @escaping ([Message]) -> Void ) {
        
        let _ = messageRef.document(userId).collection(messangerId).addSnapshotListener { snapshot, error in
            if let error {
                print("Error: listening messages \(error.localizedDescription)")
            }
            if let snapshot {
                var messages = snapshot.documents.compactMap( { try? $0.data(as: Message.self)})
                messages.sort(by: { $0.timeStamp.dateValue() < $1.timeStamp.dateValue() })
                completion(messages)
            }
        }
    }
    
    static func fetchUsersWithMessages(userId: String, otherUsers: [User]) async throws -> [Message] {
        var messages = [Message]()
        for user in otherUsers {
            let snap = try await messageRef.document(userId).collection(user.id).order(by: "timeStamp").getDocuments()
            let message = snap.documents.compactMap( { try? $0.data(as: Message.self) } )
            if let last = message.last, !message.isEmpty {
                messages.append(last)
            }
        }
        messages.sort(by: { $0.timeStamp.dateValue() < $1.timeStamp.dateValue() } )
        return messages
    }
    
    static func sharePost(toUsers users: [User], post: Post, messageText: String) async throws {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        for user in users {
            var message = Message(messageId: UUID().uuidString, ownerUid: userId, messageWithId: user.id, messageText: messageText, post: post, timeStamp: Timestamp())
            let data = try Firestore.Encoder().encode(message)
            let _ = try await messageRef.document(message.ownerUid).collection(message.messageWithId).addDocument(data: data)
            let _ = try await messageRef.document(message.messageWithId).collection(message.ownerUid).addDocument(data: data)
//            try await addMessage(message: message)
        }
        
    }
}
