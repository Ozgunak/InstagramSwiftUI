//
//  EditProfileView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-23.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: EditProfileViewModel
    @State private var isLoading: Bool = false

    init(user: User) {
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    var body: some View {
        ZStack {
            if isLoading {
                LottiePlusView(name: .loading, loopMode: .loop)
            }
            VStack {
                HStack{
                    Button("Cancel") {
                        dismiss()
                    }
                    Spacer()
                    Text("Edit Profile")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Spacer()
                    Button(action: {
                        Task {
                            isLoading = true
                            try await viewModel.updateUserData()
                            isLoading = false
                            dismiss()                        
                        }
                    }, label: {
                        Text("Done")
                            .fontWeight(.semibold)
                    })
                }
                .padding(.horizontal)
                PhotosPicker(selection: $viewModel.selectedImage) {
                    VStack {
                        if let image = viewModel.profileImage {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(.circle)
                        
                        } else {
                            IGCircularProfileImageView(user: viewModel.user)
                        }
                    
                    Text("Edit Profile Picture")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    }
                }
                
                Divider()
                VStack {
                    EditProfileRowView(title: "Full Name", placeHolder: "Enter your name", text: $viewModel.fullname)
                    EditProfileRowView(title: "Bio", placeHolder: "Enter your bio", text: $viewModel.bio)
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
    }
}


struct EditProfileRowView: View {
    let title: String
    let placeHolder: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            Text(title)
                .padding(.leading, 8)
                .frame(width: 100, alignment: .leading)
            
            VStack {
                TextField(placeHolder, text: $text)
            
                Divider()
            }
        }
        .font(.subheadline)
        .frame(height: 36)
    }
}
#Preview {
    EditProfileView(user: User.MOCK_USERS.first!)
}
