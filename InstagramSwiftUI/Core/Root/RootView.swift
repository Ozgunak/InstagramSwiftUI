//
//  RootView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-23.
//

import SwiftUI
import Firebase
import Combine

@MainActor
class RootViewModel: ObservableObject {
    private let service = AuthService.shared
    private var cancellables = Set<AnyCancellable>()
    
    @Published var userSessions: FirebaseAuth.User?
    @Published var currentUser: User?

    init() {
        setupSubscribers()
    }
    
    func setupSubscribers() {
        service.$userSession.sink { userSession in
            self.userSessions = userSession
        }
        .store(in: &cancellables)
        
        service.$currentUser.sink { currentUser in
            self.currentUser = currentUser
        }
        .store(in: &cancellables)
    }
}


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
