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
    var body: some View {
        VStack {
            HStack {
                if let user = post.user {
                    IGCircularProfileImageView(user: user, size: .small)
                    
                    Text(user.username)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.leading, 4)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        
            
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
            
            Text("6h")
                .font(.footnote)
                .fontWeight(.thin)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 2)
        }
    }
}

#Preview {
    HomeItem(post: Post(id: "1", ownerUid: "1", caption: "", likes: 1, imageURL: "", timeStamp: Timestamp()))
}
