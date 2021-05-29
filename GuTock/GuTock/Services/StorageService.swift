//
//  StorageService.swift
//  GuTock
//
//  Created by Владимир Гуль on 29.05.2021.
//

import UIKit
import FirebaseStorage
import FirebaseAuth

class StorageService {
    
    static let shared = StorageService()
    
    let storageRef = Storage.storage().reference()
    
    private var avatarRef: StorageReference {
        return storageRef.child("avatars")
    }
    
    private var currentUserID: String {
        guard let currentUserUID = Auth.auth().currentUser?.uid else {
            print("ID error")
            return "ID error"
        }
        return currentUserUID
    }
    
    func upload(photo: UIImage, completion: @escaping (Result<URL,Error>) -> Void) {
        
        guard let scaledImage = photo.scaledToSafeUploadSize, let imageData = scaledImage.jpegData(compressionQuality: 0.4) else {
            print("Someathing wrong with image convertation")
            return
        }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        avatarRef.child(currentUserID).putData(imageData, metadata: metadata) { metadata, error in
            guard let _ = metadata else {
                completion(.failure(error!))
                return
            }
            
            self.avatarRef.child(self.currentUserID).downloadURL { URL, error in
                guard let downloadURL = URL else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(downloadURL))
            }
            
        }
        
    }
    
}
 
