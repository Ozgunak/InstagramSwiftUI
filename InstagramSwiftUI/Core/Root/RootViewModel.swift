//
//  RootViewModel.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-24.
//

import Foundation
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
