//
//  SearchView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-23.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText: String = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(User.MOCK_USERS) { user in
                        NavigationLink(value: user) {
                            HStack {
                                Image(user.profileImageURL ?? "")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(.circle)
                                
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
                ProfileView(user: user)
            }
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SearchView()
}
