//
//  ProfileHeaderView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-24.
//

import SwiftUI

struct ProfileHeaderView: View {
    let user: User
    var body: some View {
        VStack {
            HStack(spacing: 30){
                IGCircularProfileImageView(user: user)
                Spacer()
                ProfileStatsView(count: 13, title: "Posts")
                ProfileStatsView(count: 100, title: "Followers")
                ProfileStatsView(count: 134, title: "Following")
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
    ProfileHeaderView(user: User.MOCK_USERS.first!)
}
