//
//  MessageView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-27.
//

import SwiftUI
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
    }
}

struct MessageView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: MessageViewModel
    
    init(messanger: User) {
        self._viewModel = StateObject(wrappedValue: MessageViewModel(messanger: messanger))
    }
    var body: some View {
        VStack {
            
            if viewModel.messages.isEmpty {
                Spacer()
                Text("No messages yet")
                    .font(.title)
                Text("Start the conversation.")
                    .font(.footnote)
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.messages) { message in
                            if let messanger = viewModel.messanger {
                                if message.messageWithId == Auth.auth().currentUser?.uid {
                                    HStack {
                                        IGCircularProfileImageView(user: messanger, size: .small)
                                    
                                        VStack(alignment: .leading) {
                                            Text(message.messageText)
                                                .padding(.vertical, 4)
                                                .padding(.horizontal, 6)
                                                .clipShape(.rect(cornerRadius: 6))
                                            .overlay(RoundedRectangle(cornerRadius: 6).stroke(.gray, lineWidth: 1))
                                            
                                            Text(message.timeStamp.dateValue().formatted(.relative(presentation: .numeric)))
                                                .font(.footnote)
                                                .fontWeight(.thin)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }

                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                } else {
                                    HStack {
                                        Spacer()
                                    
                                        VStack(alignment: .trailing) {
                                            Text(message.messageText)
                                                .padding(.vertical, 4)
                                                .padding(.horizontal, 6)
                                                .background(.thinMaterial)
                                                .clipShape(.rect(cornerRadius: 6))
                                            
                                            Text(message.timeStamp.dateValue().formatted(.relative(presentation: .numeric)))
                                                .font(.footnote)
                                                .fontWeight(.thin)
                                                .frame(maxWidth: .infinity, alignment: .trailing)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                }          
            }
            Spacer()
            HStack {
                if let user = viewModel.user {
                    IGCircularProfileImageView(user: user, size: .medium)
                }
                
                TextField("Message...", text: $viewModel.messageText, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                
                if !viewModel.messageText.isEmpty {
                    Button {
                        Task {
                            try await viewModel.addMessage()
                            viewModel.messageText = ""
                        }
                    } label: {
                        Text("Post")
                            .foregroundStyle(.blue)
                    }
                    
                }
            }
            .padding(.horizontal)
            
            
            
        }
        .navigationTitle(viewModel.messanger?.username ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
            }
            
        }
    }
}

#Preview {
    NavigationStack {
        MessageView(messanger: User.MOCK_USER)
    }
}
