//
//  CommentView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-25.
//

import SwiftUI
import Firebase

struct CommentView: View {
    @StateObject var viewModel: CommentViewModel
    @State private var currentUser: User?
    
    init(post: Post) {
        self._viewModel = StateObject(wrappedValue: CommentViewModel(post: post))
    }
    var body: some View {
        VStack {
                Text("Comments")
                    .font(.title3)
                    .fontWeight(.semibold)
                .padding(.top)
            
            
            Divider()
            
            if viewModel.comments.isEmpty {
                Spacer()
                Text("No comments yet")
                    .font(.title)
                Text("Start the conversation.")
                    .font(.footnote)
            } else {
                ScrollView {
                    LazyVStack{
                        ForEach(viewModel.comments) { comment in
                            CommentItem(comment: comment)
                                .padding(.bottom)
                        }
                    }
                }
            }
            Spacer()
            HStack {
                if let currentUser {
                    IGCircularProfileImageView(user: currentUser, size: .medium)
                }
                
                TextField("Add a comment for this post...", text: $viewModel.commentText, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                
                if !viewModel.commentText.isEmpty {
                    Button {
                        Task {
                            try await viewModel.addComment()
                            try await viewModel.fetchComments()
                            viewModel.commentText = ""
                            //                            try await vi
                        }
                    } label: {
                        Text("Post")
                            .foregroundStyle(.blue)
                    }
                    
                }
            }
        }
        .padding(.horizontal)
        .task {
            do {
                if let currentUserUid = Auth.auth().currentUser?.uid {
                    currentUser = try await UserManager.getUser(userID: currentUserUid)
                }
                try await viewModel.fetchComments()
            } catch {
                print("Error: fetch comments \(error.localizedDescription)")
            }
        }
    }
    
}


struct CommentItem: View {
    let comment: Comment
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                if let user = comment.user {
                    IGCircularProfileImageView(user: user, size: .small)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text(user.username)
                                .font(.footnote)
                            
                            Text(comment.timeStamp.dateValue().formatted(.relative(presentation: .numeric)))
                                .font(.footnote)
                                .fontWeight(.thin)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Text(comment.text)
                            .font(.body)
                    }
                }
            }
        }
    }
}

#Preview {
    CommentView(post: Post.MOCK_POST)
}
