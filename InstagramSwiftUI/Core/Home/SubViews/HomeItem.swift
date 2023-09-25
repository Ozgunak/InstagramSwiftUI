//
//  HomeItem.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-18.
//

import SwiftUI
import Kingfisher
import Firebase

struct HomeItem: View {
    let post: Post
    let isNavLinkAvaible: Bool
    
    init(post: Post, isNavLinkAvaible: Bool = true) {
        self.post = post
        self.isNavLinkAvaible = isNavLinkAvaible
    }
    
    var body: some View {
        VStack {
            HStack {
                if let user = post.user {
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
                    PostsView(user: post.user, post: post)
                        .navigationBarBackButtonHidden()
                    
                } label: {
                    postBody
                }
            } else {
                postBody
            }
            Text(post.timeStamp.dateValue().formatted(.relative(presentation: .numeric)))
                .font(.footnote)
                .fontWeight(.thin)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 2)
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
            KFImage(URL(string: post.imageURL))
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .clipShape(.rect)
            
            HStack{
                Image(systemName: "heart")
                Image(systemName: "bubble.right")
                Image(systemName: "paperplane")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, 2)
            
            Group {
                Text("\(post.user?.fullName ?? "") ").fontWeight(.semibold) +
                Text(post.caption)
                
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
