//
//  ProfileHeaderView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-24.
//

import SwiftUI

struct ProfileHeaderView: View {
    let user: User
    let postCount: Int
    var body: some View {
        VStack {
            HStack(spacing: 30){
                IGCircularProfileImageView(user: user)
                Spacer()
                ProfileStatsView(count: postCount, title: "Posts")
                ProfileStatsView(count: user.followers?.count ?? 0, title: "Followers")
                ProfileStatsView(count: user.following?.count ?? 0, title: "Following")
            }
            .padding(.horizontal)


            
            VStack(alignment: .leading ) {
                Text(user.fullName ?? "-")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text(user.bio ?? "-")
                    .font(.subheadline)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    ProfileHeaderView(user: User.MOCK_USERS.first!, postCount: 0)
}
