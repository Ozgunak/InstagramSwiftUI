//
//  RootView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-23.
//

import SwiftUI

struct RootView: View {
    @StateObject var viewModel = RootViewModel()
    @StateObject var registrationViewModel = RegistrationViewModel()

    var body: some View {
        Group {
            if viewModel.userSessions == nil {
                LoginView()
                    .environmentObject(registrationViewModel)
            } else if let currentUser = viewModel.currentUser {
                MainTabView(user: currentUser)
            }
        }
    }
}

#Preview {
    RootView()
}
