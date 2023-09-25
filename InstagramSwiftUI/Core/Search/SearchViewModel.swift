//
//  SearchViewModel.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-24.
//

import Foundation

@MainActor
class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    
    func fetchAllUsers() async throws {
        users = try await UserManager.fetchAllUsers()
    }
}
