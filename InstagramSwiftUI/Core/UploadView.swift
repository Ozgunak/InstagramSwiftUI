//
//  UploadView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-21.
//

import SwiftUI

struct UploadView: View {
    @State private var isLoading: Bool = false
    @State private var caption: String = ""
    @State private var isPickerPresented: Bool = false
    @StateObject var viewModel = UploadViewModel()
    @Binding var tabIndex: Int

    var body: some View {
        
        ZStack {
            if isLoading {
                ProgressView()
            }
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
                            isLoading = true
                            try await viewModel.uploadPost(caption: caption)
                            clearPostData()
                            isLoading = false
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

