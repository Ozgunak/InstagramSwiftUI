//
//  IGCircularProfileImageView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-24.
//

import SwiftUI
import Kingfisher

struct IGCircularProfileImageView: View {
    let user: User
    var body: some View {
        if let imageURL = user.profileImageURL {
            KFImage(URL(string: imageURL))
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .foregroundColor(Color(.systemGray4))
        }
    }
}

#Preview {
    IGCircularProfileImageView(user: User.MOCK_USERS.first!)
}
