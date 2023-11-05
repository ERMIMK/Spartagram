//
//  StoryImageUploader.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/31/23.
//
import Foundation
import Firebase
import FirebaseStorage
import UIKit

struct StoryImageUploader {
    
    static func uploadImage(image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion(.failure(UploaderError.imageConversionFailed))
            return
        }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/story_images/\(filename)")
        
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("DEBUG: Failed to upload image with error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            ref.downloadURL { imageUrl, error in
                if let error = error {
                    completion(.failure(error))
                } else if let imageUrl = imageUrl?.absoluteString {
                    completion(.success(imageUrl))
                }
            }
        }
    }

    enum UploaderError: Error {
        case imageConversionFailed
        case urlRetrievalFailed
    }
}
