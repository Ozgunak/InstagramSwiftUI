//
//  HomeView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-18.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 32) {
                    ForEach(viewModel.posts) { post in
                        HomeItem(post: post)
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
            .task {
                do {
                    try await viewModel.fetchPosts()
                } catch {
                    print("Error: error fetching posts \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
