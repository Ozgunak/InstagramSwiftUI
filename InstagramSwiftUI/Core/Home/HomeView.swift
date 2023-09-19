//
//  HomeView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-18.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 32) {
                    ForEach(1...10, id: \.self) { item in
                        HomeItem()
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
