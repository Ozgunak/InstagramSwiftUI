//
//  UploadView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-21.
//

import SwiftUI
import PhotosUI
import Firebase

@MainActor
class UploadViewModel: ObservableObject {
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(from: selectedImage) } }
    }
    @Published var postImage: Image?
    private var uiImage: UIImage?
    
    func loadImage(from item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.postImage = Image(uiImage: uiImage)
    }
    
    func uploadPost(caption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let uiImage else { return }
        
        let postRef = Firestore.firestore().collection("posts").document()
        guard let imageUrl = try await StorageManager.uploadImage(image: uiImage, savePath: .post) else { return }
        let post = Post(id: postRef.documentID, ownerUid: uid, caption: caption, likes: 0, imageURL: imageUrl, timeStamp: Timestamp(), user: nil)
        guard let encodedPost = try? Firestore.Encoder().encode(post) else { return }
        try await postRef.setData(encodedPost)
    }
}

struct UploadView: View {
    
    @State private var caption: String = ""
    @State private var isPickerPresented: Bool = false
    @StateObject var viewModel = UploadViewModel()
    @Binding var tabIndex: Int

    var body: some View {
        
        VStack {
            HStack {
                Button(role: .cancel) {
                    clearPostData()
                    
                } label: {
                    Text("Cancel")
                }
                
                Spacer()
                
                Text("New Post")
                
                Spacer()
                
                Button {
                    Task {
                        try await viewModel.uploadPost(caption: caption)
                        clearPostData()
                    }
                } label: {
                    Text("Upload")
                }
            }
            .padding(.horizontal)
            
            HStack {
                if let image = viewModel.postImage {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipped()
                }
                
                TextField("Enter your caption...", text: $caption, axis: .vertical)
            }
            .padding()
            
            Spacer()
        }
        .onAppear {
            isPickerPresented.toggle()
        }
        .photosPicker(isPresented: $isPickerPresented, selection: $viewModel.selectedImage)
    }
    
    private func clearPostData() {
        caption = ""
        viewModel.selectedImage = nil
        viewModel.postImage = nil
        tabIndex = 0
    }
}

#Preview {
    UploadView(tabIndex: .constant(0))
}

