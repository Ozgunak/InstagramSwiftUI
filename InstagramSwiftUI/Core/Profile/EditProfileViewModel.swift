//
//  EditProfileViewModel.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-24.
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

