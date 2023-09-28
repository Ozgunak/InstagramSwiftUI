//
//  MessageUserViewModel.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-27.
//

import Foundation
import Firebase

@MainActor
class MessageUserViewModel: ObservableObject {
    @Published var message: Message
    @Published var messanger: User?
    
    init(message: Message) {
        self.message = message
    }
    
    func getMessageUser() async throws {
        messanger = try await UserManager.getUser(userID: message.messageWithId)
    }
}
