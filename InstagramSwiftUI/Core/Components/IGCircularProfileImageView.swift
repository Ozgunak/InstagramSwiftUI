//
//  IGCircularProfileImageView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-24.
//

import SwiftUI
import Kingfisher

enum CircularImageSize {
    case small
    case medium
    case large
    
    var dimentions: CGFloat {
        switch self {
        case .small:
            return 40
        case .medium:
            return 48
        case .large:
            return 80
        }
    }
}
struct IGCircularProfileImageView: View {
    let user: User
    var size: CircularImageSize = .large
    var body: some View {
        if let imageURL = user.profileImageURL {
            KFImage(URL(string: imageURL))
                .resizable()
                .scaledToFill()
                .frame(width: size.dimentions, height: size.dimentions)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: size.dimentions, height: size.dimentions)
                .clipShape(Circle())
                .foregroundColor(Color(.systemGray4))
        }
    }
}

#Preview {
    IGCircularProfileImageView(user: User.MOCK_USERS.first!)
}
