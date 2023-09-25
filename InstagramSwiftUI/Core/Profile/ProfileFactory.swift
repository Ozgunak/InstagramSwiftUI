//
//  ProfileFactory.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-23.
//

import SwiftUI

struct ProfileFactory: View {
    let user: User
    let navStackNeeded: Bool
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            if user.isCurrentUser && navStackNeeded {
                NavigationStack {
                    UserProfileView(user: user)
                }
            } else if user.isCurrentUser {
                UserProfileView(user: user)
                    .navigationBarBackButtonHidden()
            } else {
                ProfileView(user: user)
                    .navigationBarBackButtonHidden()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
            }
        }
    }
}

#Preview {
    ProfileFactory(user: User.MOCK_USERS.first!, navStackNeeded: true)
}
