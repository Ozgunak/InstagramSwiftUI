//
//  NewMessageView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-27.
//

import SwiftUI

struct NewMessageView: View {
    @Environment(\.dismiss) var dismiss
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
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .onTapGesture {
                            dismiss()
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
    NewMessageView()
}
