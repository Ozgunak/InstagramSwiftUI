//
//  CommentViewModel.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-25.
//

import Foundation
import Firebase

@MainActor
class CommentViewModel: ObservableObject {
    @Published var post: Post
    @Published var commentText: String = ""
    @Published var comments: [Comment] = []
    init(post: Post) {
        self.post = post
        self.comments = post.comments
    }
    
    func addComment() async throws {
        try await PostManager.addComment(post: post, commentText: commentText)
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let notification = Notification(fromUid: userId, toId: post.ownerUid, fromName: "", notificationText: NotificationType.comment.value, timeStamp: Timestamp())
        try await NotificationManager.addNotification(notification: notification)
    }
    
    func updateComments() async throws {
        comments = try await PostManager.getCommentsWithUser(post: post)
    }
    
    func fetchComments() async throws {
        comments = try await PostManager.fetchComments(post: post)
    }
}
