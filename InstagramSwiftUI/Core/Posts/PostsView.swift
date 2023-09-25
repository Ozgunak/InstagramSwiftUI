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
            
            HomeItem(post: viewModel.post, isNavLinkAvaible: false)
//            HStack {
//                if let user = viewModel.user {
//                    IGCircularProfileImageView(user: user, size: .small)
//                    
//                    Text(user.username)
//                        .font(.subheadline)
//                        .fontWeight(.semibold)
//                        .padding(.leading, 4)
//                    
//                    Spacer()
//                }
//            }
//            .padding(.horizontal)
//            
//            KFImage(URL(string: viewModel.post.imageURL))
//                .resizable()
//                .scaledToFill()
//                .frame(height: 500)
//                .clipped()
//            
//            HStack{
//                Image(systemName: "heart")
//                Image(systemName: "bubble.right")
//                Image(systemName: "paperplane")
//            }
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .padding(.horizontal)
//            .padding(.top, 2)
//            
//            Group {
//                Text("\(viewModel.user?.fullName ?? "") ").fontWeight(.semibold) +
//                Text(viewModel.post.caption)
//                
//            }
//            .font(.footnote)
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .padding(.horizontal)
//            .padding(.top, 2)
//            
//            Text("6h")
//                .font(.footnote)
//                .fontWeight(.thin)
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.horizontal)
//                .padding(.top, 2)
            
            Spacer()
        }
    }
    
}

#Preview {
    PostsView(user: User.MOCK_USER, post: Post.MOCK_POST)
}

