//
//  NewMessageView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-27.
//

import SwiftUI
import Firebase

@MainActor
class NewMessageViewModel: ObservableObject {
    @Published var users = [User]()
    
    func fetchAllUsers() async throws {
        var userlist = try await UserManager.fetchAllUsers()
        userlist.removeAll(where: { $0.id == Auth.auth().currentUser?.uid })
        users = userlist
    }
}

struct NewMessageView: View {
    @State private var searchText: String = ""
    @StateObject var viewModel = NewMessageViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.users) { user in
                        NavigationLink{
                            MessageView(messanger: user)
                                .navigationBarBackButtonHidden()
                        } label: {
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
            .navigationTitle("New Message")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                do {
                    try await viewModel.fetchAllUsers()
                } catch {
                    print("Error: fetching users \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    NewMessageView()
}