//
//  PostGridView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-24.
//

import SwiftUI
import Kingfisher

class PostGridViewModel: ObservableObject {
    @Published var posts = [Post]()
    private let user: User
    
    init(user: User) {
        self.user = user
        
        Task { try await fetchUserPosts() }
    }
    
    @MainActor
    func fetchUserPosts() async throws {
        self.posts = try await PostManager.fetchUserPost(userId: user.id)
        
        for i in 0 ..< posts.count {
            posts[i].user = self.user
        }
    }
}

struct PostGridView: View {
    @StateObject var viewModel: PostGridViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: PostGridViewModel(user: user))
    }
    
    let gridColumns: [GridItem] = [
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1)
    ]
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1
    
    
    var body: some View {
            LazyVGrid(columns: gridColumns, spacing: 1 ) {
                ForEach(viewModel.posts) { post in
                    KFImage(URL(string: post.imageURL))
                        .resizable()
                        .scaledToFill()
                        .frame(width: imageDimension, height: imageDimension)
                        .clipped()
                        
                        
                }
            }
        }
}

#Preview {
    PostGridView(user: User.MOCK_USERS.first!)
}
