//
//  MessageView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-27.
//

import SwiftUI
import Firebase
import Kingfisher

struct MessageView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: MessageViewModel
    
    init(messanger: User) {
        self._viewModel = StateObject(wrappedValue: MessageViewModel(messanger: messanger))
    }
    var body: some View {
        VStack {
            NavigationLink {
                if let user = viewModel.messanger {
                    ProfileFactory(user: user, navStackNeeded: false)
                }
            } label: {
                Text("Go to profile")
            }
            
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
                                            
                                            if let post = message.post {
                                                postView(post: post)
                                            }
                                            
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
                                            if let post = message.post {
                                                postView(post: post)
                                            }
                                            
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
        .task {
            try? await viewModel.getUserMessages()
        }
    }
}

extension MessageView {
    func postView(post: Post) -> some View {
        HStack {

            NavigationLink {
                PostsView(user: post.user, post: post)
                    .navigationBarBackButtonHidden()
            } label: {
                VStack {
                    KFImage(URL(string: post.imageURL))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 250, height: 250)
                        .clipped()
                        .clipShape(.rect(cornerRadius: 6))
                    Text(post.caption)
                        .font(.footnote)
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
