//
//  HomeView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-18.
//

import SwiftUI

struct HomeView: View {
    @State private var users: [User] = User.MOCK_USERS

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 32) {
                    ForEach(users) { user in
                        HomeItem(user: user)
                    }
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image("titleimage")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
