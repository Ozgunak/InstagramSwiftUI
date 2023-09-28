//
//  NewMessageViewModel.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-27.
//

import Foundation
import Firebase

@MainActor
class NewMessageViewModel: ObservableObject {
    @Published var users = [User]()
    
    func fetchAllUsers() async throws {
        var userlist = try await UserManager.fetchAllUsers()
        userlist.removeAll(where: { $0.id == Auth.auth().currentUser?.uid })
        users = userlist
    }
}
