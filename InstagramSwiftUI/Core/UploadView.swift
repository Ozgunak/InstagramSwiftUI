//
//  UploadView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-21.
//

import SwiftUI
import PhotosUI

class UploadViewModel: ObservableObject {
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(from: selectedImage) } }
    }
    @Published var postImage: Image?
    
    func loadImage(from item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.postImage = Image(uiImage: uiImage)
        
    }
}

struct UploadView: View {
    
    @State private var caption: String = ""
    @State private var isPickerPresented: Bool = false
    @StateObject var viewModel = UploadViewModel()


    var body: some View {
        
        VStack {
            HStack {
                Button(role: .cancel) {
                    caption = ""
                    viewModel.selectedImage = nil
                    viewModel.postImage = nil
                } label: {
                    Text("Cancel")
                }
                
                Spacer()
                
                Text("New Post")
                
                Spacer()
                
                Button {
                    
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
}

#Preview {
    UploadView()
}
