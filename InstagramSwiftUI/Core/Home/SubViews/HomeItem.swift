//
//  HomeItem.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-18.
//

import SwiftUI

struct HomeItem: View {
    let user: User
    var body: some View {
        VStack {
            HStack {
                IGCircularProfileImageView(user: user, size: .small)
                
                Text(user.username)
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        
            
            Image(user.profileImageURL ?? "")
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
                Text(user.fullName ?? "").fontWeight(.semibold) +
                Text("City Image 1")

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
    HomeItem(user: User.MOCK_USERS.first!)
}
