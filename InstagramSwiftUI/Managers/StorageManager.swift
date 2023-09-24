//
//  StorageManager.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-24.
//

import UIKit
import Firebase
import FirebaseStorage

enum StoragePath {
    case user
    case post
    
    var stringValue: String {
        switch self {
        case .user:
            return "profileImages"
        case .post:
            return "postImages"
        }
    }
}

struct StorageManager {
    static func uploadImage(image: UIImage, savePath: StoragePath) async throws -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return nil }
        let fileName = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "/\(savePath.stringValue)/\(fileName)")
        
        do {
            let meta = StorageMetadata()
            meta.contentType = "image/jpeg"
            let _ = try await ref.putDataAsync(imageData, metadata: meta)
            let url = try await ref.downloadURL()
            print("Succesfully uploaded Data!")
            return url.absoluteString
        } catch {
            print("Error: upload image \(error.localizedDescription)")
            return nil
        }
    }
}
