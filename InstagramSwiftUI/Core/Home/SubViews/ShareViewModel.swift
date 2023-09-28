//
//  ShareViewModel.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-28.
//

import Foundation
import Firebase

@MainActor
class ShareViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var searchResultUsers: [User] = []
    @Published var post: Post
    @Published var selectedList: [User] = []
    @Published var messageText: String = ""

    init(post: Post) {
        self.post = post
    }
    
    func fetchAllUsers() async throws {
        users = try await UserManager.fetchAllUsers()
    }
    
    func sharePost() async throws {
        try await MessageManager.sharePost(toUsers: users, post: post, messageText: messageText)
    }
    
    func isSelected(userId: String) -> Bool {
        return selectedList.contains(where: { $0.id == userId })
    }
    
    func selectToShare(user: User) {
        if !isSelected(userId: user.id) {
            selectedList.append(user)
        } else {
            selectedList.removeAll(where: { $0.id == user.id })
        }
    }
}
