//
//  ContentView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-18.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Text("Home")
                .tabItem { Image(systemName: "house") }
            
            Text("Explore")
                .tabItem { Image(systemName: "magnifyingglass") }

            Text("Add")
                .tabItem { Image(systemName: "plus.circle") }
            
            ProfileView()
                .tabItem { Image(systemName: "person") }
        }
    }
}

#Preview {
    MainTabView()
}
