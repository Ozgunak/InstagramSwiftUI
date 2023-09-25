//
//  HomeItem.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-18.
//

import SwiftUI
import Kingfisher
import Firebase

@MainActor
class HomeItemModel: ObservableObject {
    @Published var post: Post
    let currentUserId = Auth.auth().currentUser?.uid

    var isLiked: Bool {
        if let currentUserId {
            return post.likes.contains(currentUserId)
        } else {
            return false
        }
    }
    
    init(post: Post) {
        self.post = post
//        self.comments = post.comments
    }
    
    func like() async throws {
            try await PostManager.likePost(post: post)
            if let currentUserId {
                post.likes.append(currentUserId)
            }
    }
    
    func unlike() async throws {
         try await PostManager.unlikePost(post: post)
        if let currentUserId {
            post.likes.removeAll(where: { $0.contains(currentUserId) } )
        }
    }

}

struct HomeItem: View {
    let isNavLinkAvaible: Bool
    @StateObject var viewModel: HomeItemModel
    @State private var isPresented: Bool = false

    init(post: Post, isNavLinkAvaible: Bool = true) {
        self._viewModel = StateObject(wrappedValue: HomeItemModel(post: post))
        self.isNavLinkAvaible = isNavLinkAvaible
    }
    
    var body: some View {
        VStack {
            HStack {
                if let user = viewModel.post.user {
                    if isNavLinkAvaible {
                        NavigationLink {
                            ProfileFactory(user: user, navStackNeeded: false)
                                .navigationBarBackButtonHidden()
                        } label: {
                            header(user: user)
                        }
                    } else {
                        header(user: user)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            if isNavLinkAvaible {
                NavigationLink {
                    PostsView(user: viewModel.post.user, post: viewModel.post)
                        .navigationBarBackButtonHidden()
                    
                } label: {
                    postBody
                }
            } else {
                postBody
            }
            Text(viewModel.post.timeStamp.dateValue().formatted(.relative(presentation: .numeric)))
                .font(.footnote)
                .fontWeight(.thin)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 2)
        }
        .sheet(isPresented: $isPresented) {
            CommentView(post: viewModel.post)
        }
    }
}

extension HomeItem {
    func header(user: User) -> some View {
        HStack {
            IGCircularProfileImageView(user: user, size: .small)
            
            Text(user.username)
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.leading, 4)
        }
    }
    
    var postBody: some View {
        VStack {
            KFImage(URL(string: viewModel.post.imageURL))
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .clipShape(.rect)
            
            HStack{
                Button(action: {
                    if viewModel.isLiked {
                        Task { try await viewModel.unlike() }
                    } else {
                        Task { try await viewModel.like() }
                    }
                }, label: {
                    Image(systemName: viewModel.isLiked ? "heart.fill" : "heart")
                        .foregroundColor(viewModel.isLiked ? .red : .accent)
                })
                Button {
                    isPresented.toggle()
                } label: {
                    Image(systemName: "bubble.right")
                }

                Image(systemName: "paperplane")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, 2)
            
            Group {
                Text("\(viewModel.post.user?.fullName ?? "") ").fontWeight(.semibold) +
                Text(viewModel.post.caption)
                
            }
            .font(.footnote)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, 2)
        }

    }
    
    
}

#Preview {
    HomeItem(post: Post.MOCK_POST)
}
