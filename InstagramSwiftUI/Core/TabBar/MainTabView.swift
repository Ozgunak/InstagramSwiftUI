//
//  ContentView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-18.
//

import SwiftUI

struct MainTabView: View {
    let user: User
    @State private var selectedIndex = 0

    var body: some View {
        TabView(selection: $selectedIndex) {
            HomeView()
                .onAppear {
                    selectedIndex = 0
                }
                .tabItem { Image(systemName: "house") }
                .tag(0)
            
            SearchView()
                .onAppear {
                    selectedIndex = 1
                }
                .tabItem { Image(systemName: "magnifyingglass") }
                .tag(1)


            UploadView(tabIndex: $selectedIndex)
                .onAppear {
                    selectedIndex = 2
                }
                .tabItem { Image(systemName: "plus.circle") }
                .tag(2)

            
            NotificationView()
                .onAppear {
                    selectedIndex = 3
                }
                .tabItem { Image(systemName: "heart") }
                .tag(3)

            
            ProfileFactory(user: user, navStackNeeded: true)
                .onAppear {
                    selectedIndex = 4
                }
                .tabItem { Image(systemName: "person") }
                .tag(4)

        }
    }
}

#Preview {
    MainTabView(user: User.MOCK_USERS[0])
}
