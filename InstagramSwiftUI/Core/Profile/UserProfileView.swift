//
//  UserProfileView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-23.
//

import SwiftUI

struct UserProfileView: View {
    let gridColumns: [GridItem] = [
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1)
    ]
    
    let user: User
    @State private var isPresented: Bool = false

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
            .fullScreenCover(isPresented: $isPresented) {
                Text("hi")
            }
            
        
    }
}

extension UserProfileView {
    var headerView: some View {
        VStack {
            HStack(spacing: 30){
                Image(user.profileImageURL ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(.circle)
                
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
        Button(action: {
            isPresented.toggle()
        }, label: {
            Text("Edit Profile")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: 360, height: 32)
                .overlay(RoundedRectangle(cornerRadius: 6).stroke(.gray, lineWidth: 1))
        })
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
    UserProfileView(user: User.MOCK_USERS.first!)
}
