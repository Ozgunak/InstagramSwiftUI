//
//  AllMessagesViewModel.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-27.
//

import Foundation
import Firebase

@MainActor
class AllMessagesViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var messages: [Message] = []
    
    func fetchAllUsers() async throws {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        users = try await UserManager.fetchAllUsers()
        users.removeAll(where: { $0.id == Auth.auth().currentUser?.uid })
        messages = try await MessageManager.fetchUsersWithMessages(userId: userId, otherUsers: users)
    }
}
