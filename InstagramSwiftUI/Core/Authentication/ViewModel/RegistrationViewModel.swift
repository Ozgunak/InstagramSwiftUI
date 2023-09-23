//
//  RegistrationViewModel.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-23.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var username = ""
    
    func createUser() async throws {
        try? await AuthService.shared.createUser(email: email, password: password, username: username)
        
        email = ""
        password = ""
        username = ""
    }
}
