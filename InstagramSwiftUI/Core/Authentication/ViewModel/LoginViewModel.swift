//
//  LoginViewModel.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-23.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func login() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }

}
