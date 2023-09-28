//
//  NotificationView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-27.
//

import SwiftUI
import Firebase

@MainActor
class NotificationViewModel: ObservableObject {
    @Published var notifications: [Notification] = []
    @Published var user: User?
    init() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        Task {
            user = try await UserManager.getUser(userID: userId)
             NotificationManager.fetchNotifications(for: userId, completion: { [weak self] newNotifications in
                 self?.notifications = newNotifications
            })
        }
    }
    
    
}

struct NotificationView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = NotificationViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.notifications) { notification in
                            HStack {
                                
                                Text(notification.notificationText)
                                    .font(.subheadline)
                                    .lineLimit(2)
                                    .padding(.leading, 6)
                                
                                Spacer()
                                
                                Text(notification.timeStamp.dateValue().formatted(.relative(presentation: .named)))
                                    .font(.footnote)
                                    .fontWeight(.thin)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                        }
                    }
                }
                
            }
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

#Preview {
        NotificationView()
    
}
