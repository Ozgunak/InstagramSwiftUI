//
//  HomeItemView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-18.
//

import SwiftUI
import Kingfisher
import Firebase



struct HomeItemView: View {
    @StateObject var viewModel: HomeItemViewModel
    @State private var isPresented: Bool = false

    init(post: Post, isNavLinkAvaible: Bool = true) {
        self._viewModel = StateObject(wrappedValue: HomeItemViewModel(post: post))
    }
    
    var body: some View {
        VStack {
            HStack {
                if let user = viewModel.post.user {
                    NavigationLink {
                        ProfileFactory(user: user, navStackNeeded: false)
                            .navigationBarBackButtonHidden()
                    } label: {
                        header(user: user)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    
                }
            }
            
            
            postBody
            
            Text(viewModel.post.timeStamp.dateValue().formatted(.relative(presentation: .numeric)))
                .font(.footnote)
                .fontWeight(.thin)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
        .sheet(isPresented: $isPresented) {
            CommentView(post: viewModel.post)
        }
    }
}

extension HomeItemView {
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
            
            HStack {
                Text("^[\(viewModel.post.likes.count) like](inflect: true)")
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
            }
            
            Button {
                isPresented.toggle()
            } label: {
                Text("View all comments")
                    .font(.footnote)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
            }
        }
    } 
}

#Preview {
    HomeItemView(post: Post.MOCK_POST)
}
