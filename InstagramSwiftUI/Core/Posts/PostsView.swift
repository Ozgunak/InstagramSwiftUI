//
//  PostsView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-24.
//

import SwiftUI
import Kingfisher

struct PostsView: View {
    @StateObject var viewModel: PostsViewModel
    @Environment(\.dismiss) var dismiss
    init(user: User?, post: Post) {
        self._viewModel = StateObject(wrappedValue: PostsViewModel(user: user, post: post))
    }
    var body: some View {
        VStack{
            
            HStack {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
                
                Spacer()
                
                VStack {
                    Text(viewModel.user?.username ?? "")
                        .foregroundStyle(Color(.systemGray4))
                    
                    Text("Post")
                    
                }
                .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "ellipsis.message")
                    .imageScale(.large)
                    .onTapGesture {
                        // TODO: add message
                    }
            }
            .padding(.horizontal)
            
                
            HomeItemView(post: viewModel.post, isNavLinkAvaible: false)
            ScrollView {

                LazyVStack(content: {
                    ForEach(viewModel.comments) { comment in
                        CommentItem(comment: comment)
                            .padding(.horizontal)
                    }
                })
            }

            

        }
        .task {
            do {
                try await viewModel.fetchComments()
            } catch {
                print("Error: updating comments \(error.localizedDescription)")
            }
        }
    }
    
}

#Preview {
    PostsView(user: User.MOCK_USER, post: Post.MOCK_POST)
}

