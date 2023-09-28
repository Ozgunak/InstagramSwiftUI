//
//  AllMessagesView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-26.
//

import SwiftUI
import Firebase

@MainActor
class AllMessagesViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var messages: [Message] = []
    
    func fetchAllUsers() async throws {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        users = try await UserManager.fetchAllUsers()
        let otherUsers = users.filter({ $0.id != userId })
        messages = try await MessageManager.fetchUsersWithMessages(userId: userId, otherUsers: otherUsers)
    }
}

struct AllMessagesView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: AllMessagesViewModel = AllMessagesViewModel()
    

    var body: some View {
        VStack {
            ScrollView{
                LazyVStack {
                    ForEach(viewModel.messages) { message in
                        NavigationLink {
                            if let messanger = viewModel.users.first(where: { $0.id == message.messageWithId }) {
                                MessageView(messanger: messanger)
                                    .navigationBarBackButtonHidden()
                            }
                        } label: {
                            MessageUserView(message: message)
                                .padding(.bottom, 4)
                            
                        }
                        Text(message.messageWithId).hidden().font(.system(size: 8)) // dummy text
                    }
                }
            }
            .task {
                try? await viewModel.fetchAllUsers()
            }
            .navigationTitle("Messages")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .onTapGesture {
                            dismiss()
                        }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        NewMessageView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        Image(systemName: "plus.bubble")
                    }

                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AllMessagesView()
    }
}


