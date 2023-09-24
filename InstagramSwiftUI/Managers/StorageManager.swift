//
//  StorageManager.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-24.
//

import UIKit
import Firebase
import FirebaseStorage

struct StorageManager {
    static func uploadImage(image: UIImage) async throws -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return nil }
        let fileName = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profileImages/\(fileName)")
        
        do {
            let meta = StorageMetadata()
            meta.contentType = "image/jpeg"
            let _ = try await ref.putDataAsync(imageData, metadata: meta)
            let url = try await ref.downloadURL()
            return url.absoluteString
            print("Succesfully uploaded Data!")
        } catch {
            print("Error: upload image \(error.localizedDescription)")
            return nil
        }
    }
}
