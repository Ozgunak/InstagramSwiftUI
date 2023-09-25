//
//  EditProfileView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-23.
//

import SwiftUI
import PhotosUI
import Firebase

@MainActor
class EditProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(from: selectedImage) } }
    }
    @Published var profileImage: Image?
    @Published var fullname: String = ""
    @Published var bio: String = ""
    private var uiImage: UIImage?
    init(user: User) {
        self.user = user
        
        if let fullName = user.fullName {
            self.fullname = fullName
        }
        if let bio = user.bio {
            self.bio = bio
        }
    }
    
    func loadImage(from item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
        
    }
    
    func updateUserData() async throws {
        
        var data: [String: Any] = [:]
        
        if let uiImage {
            let profileString = try? await StorageManager.uploadImage(image: uiImage, savePath: .user)
            data["profileImageURL"] = profileString
            self.profileImage = Image(uiImage: uiImage)
        }
        
        if !fullname.isEmpty && user.fullName != fullname {
            data["fullName"] = fullname
            self.fullname = fullname
        }
        if !bio.isEmpty && user.bio != bio {
            data["bio"] = bio
            self.bio = bio
        }
        if !data.isEmpty {
            try await Firestore.firestore().collection("users").document(user.id).updateData(data)
        }
        
    }
}


struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: EditProfileViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    var body: some View {
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
                        try await viewModel.updateUserData()
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
