//
//  SearchView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-23.
//

import SwiftUI
import Firebase

class SearchViewModel: ObservableObject {
    
    @Published var users = [User]()
    
    init() {
        Task { try await fetchAllUsers() }
    }
    
    func fetchAllUsers() async throws {
        users = try await UserManager.fetchAllUsers()
    }
}

struct SearchView: View {
    
    @State private var searchText: String = ""
    @StateObject var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.users) { user in
                        NavigationLink(value: user) {
                            HStack {
                                IGCircularProfileImageView(user: user, size: .small)
                                
                                VStack(alignment: .leading) {
                                    Text(user.username)
                                        .fontWeight(.semibold)
                                    
                                    if user.fullName != nil {
                                        Text(user.fullName!.capitalized)
                                    }
                                }
                                .font(.footnote)
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.top, 8)
                .searchable(text: $searchText, prompt: "Search...")
                
            }
            .navigationDestination(for: User.self) { user in
                ProfileFactory(user: user, navStackNeeded: false)
            }
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SearchView()
}
