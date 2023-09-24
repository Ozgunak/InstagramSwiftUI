//
//  ProfileView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-18.
//

import SwiftUI

struct ProfileView: View {
    let gridColumns: [GridItem] = [
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1)
    ]
    
    let user: User

    var body: some View {
        
        ScrollView {
            VStack {
                
                headerView
                
                actionButton
                
                gridView
                
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Text("")
                    Text("")
                    Button("SignOut") {
                        AuthService.shared.signout()
                    }
                } label: {
                    Image(systemName: "line.3.horizontal")
                }
            }
        }
        
        
    }
}

extension ProfileView {
    var headerView: some View {
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
                Text(user.fullName ?? "")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text(user.bio ?? "")
                    .font(.subheadline)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    var actionButton: some View {
        Button {
            if user.isCurrentUser {
            } else {
                
            }
        } label: {
            Text("Follow")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: 360, height: 32)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.rect(cornerRadius: 6))
                .overlay(RoundedRectangle(cornerRadius: 6).stroke(.gray, lineWidth: 1))
        }
    }
    
    var gridView: some View {
        LazyVGrid(columns: gridColumns, spacing: 1 ) {
            ForEach(1...60, id: \.self) { index in
                Image("city\(index % 6 + 1)")
                    .resizable()
                    .scaledToFill()
                    
                    
            }
        }
    }
}

#Preview {
    ProfileView(user: User.MOCK_USERS.first!)
}
