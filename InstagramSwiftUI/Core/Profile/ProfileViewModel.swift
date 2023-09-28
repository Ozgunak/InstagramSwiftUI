//
//  ProfileViewModel.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-24.
//

import Foundation
import Firebase

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var posts = [Post]()
    @Published var isLoading: Bool = false

    init(user: User) {
        self.user = user
    }
    
    func fetchUserPosts() async throws {
        isLoading = true
        self.posts = try await PostManager.fetchUserPost(userId: user.id)
        
        for i in 0 ..< posts.count {
            posts[i].user = self.user
        }
        isLoading = false
    }
    
    func isFollowing() -> Bool {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return false }
        
        if let followers = user.followers {
            return followers.contains(currentUserId)
        } else {
            return false
        }
    }
    
    func follow() async throws {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        try await UserManager.follow(followingUserId: currentUserId, followedId: user.id)
        user.followers?.append(currentUserId)
        
        let notification = Notification(fromUid: currentUserId,
                                        toId: user.id,
                                        fromName: user.username,
                                        notificationText: NotificationType.follow.value,
                                        timeStamp: Timestamp())
        try await NotificationManager.addNotification(notification: notification)
    }
    
    func unfollow() async throws {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        try await UserManager.unfollow(followingUserId: currentUserId, followedId: user.id)
        
        user.followers?.removeAll(where: { $0.contains(currentUserId)})
    }
}
