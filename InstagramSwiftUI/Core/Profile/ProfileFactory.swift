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
    var body: some View {
        VStack {
            if user.isCurrentUser && navStackNeeded {
                NavigationStack {
                    UserProfileView(user: user)
                }
            } else if user.isCurrentUser {
                UserProfileView(user: user)
            } else {
                ProfileView(user: user)
            }
        }
    }
}

#Preview {
    ProfileFactory(user: User.MOCK_USERS.first!, navStackNeeded: true)
}
