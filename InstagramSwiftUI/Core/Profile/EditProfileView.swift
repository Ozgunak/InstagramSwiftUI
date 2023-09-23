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
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(from: selectedImage) } }
    }
    @Published var profileImage: Image?
    @Published var fullname: String = ""
    @Published var bio: String = ""
    
    func loadImage(from item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.profileImage = Image(uiImage: uiImage)
        
    }
}


struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = EditProfileViewModel()

    var body: some View {
        VStack {
            PhotosPicker(selection: $viewModel.selectedImage) {
                VStack {
                    if let image = viewModel.profileImage {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(.circle)
                    
                    } else {
                        Image("")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(.circle)
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
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}, label: {
                    Text("Done")
                        .fontWeight(.semibold)
                })
            }
        })
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
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
    NavigationStack {
        EditProfileView()
    }
}
