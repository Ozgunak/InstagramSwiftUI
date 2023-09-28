//
//  ShareView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-28.
//

import SwiftUI

struct ShareView: View {
    @StateObject var viewModel: ShareViewModel
    @Environment(\.dismiss) var dismiss
    @State private var searchText: String = ""
    @State private var isSelected: Bool = false
    
    init(post: Post) {
        self._viewModel = StateObject(wrappedValue: ShareViewModel(post: post))
    }
    var body: some View {
        NavigationStack {
            VStack {
                // searchable
                List {
                    ForEach(searchText.isEmpty ? viewModel.users : viewModel.searchResultUsers) { user in
                        HStack {
                            IGCircularProfileImageView(user: user, size: .small)
                            VStack(alignment: .leading) {
                                if user.fullName != nil {
                                    Text(user.fullName!.capitalized)
                                }
                                
                                Text(user.username)
                                    .fontWeight(.semibold)
                            }
                            .font(.footnote)
                            
                            Spacer()
                            
                            Button {
                                viewModel.selectToShare(user: user)
                            } label: {
                                Image(systemName: viewModel.isSelected(userId: user.id) ? "circlebadge.fill" : "circlebadge")
                            }
                            
                            .padding(.horizontal)
//                            .padding(.top)
                        }
                    }
                }
                .listStyle(.plain)
                .padding(.top, 8)
                .searchable(text: $searchText, prompt: "Search...")
                .animation(.default, value: searchText)
                .onChange(of: searchText, initial: true) {
                    viewModel.searchResultUsers = viewModel.users.filter( { user in
                        user.username.lowercased().contains(searchText.lowercased())
                    })
                }
                
                if !viewModel.selectedList.isEmpty {
                    Group {
                        Divider()
                        TextField("Write a message...", text: $viewModel.messageText, axis: .vertical)
                            .padding(.horizontal)
                        Divider()
                        Button {
                            Task {
                                try? await viewModel.sharePost()
                                viewModel.selectedList.removeAll()
                                viewModel.messageText = ""
                                dismiss()
                            }
                        } label: {
                            Text("Send")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .frame(width: 360, height: 44)
                                .background(.blue.gradient)
                                .clipShape(.rect(cornerRadius: 8))
                        }
                        .padding(.vertical)
                    }
                }
            }
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
    ShareView(post: Post.MOCK_POST)
    
}
