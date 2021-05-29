//
//  FirestoreService.swift
//  GuTock
//
//  Created by Владимир Гуль on 27.05.2021.
//

import UIKit
import Firebase
import FirebaseFirestore

class FirestoreService {
    static let shared = FirestoreService()
    let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    
    func saveProfileWith(id: String, email: String, username: String?, avatarImage: UIImage?, description: String?, sex: String?,
                         completion: @escaping (Result<MUser,Error>) -> Void) {
        
        guard Validators.isFilled(username: username, description: description, sex: sex) else {
            completion(.failure(UserError.notFilled))
            return
        }
        
        guard avatarImage != #imageLiteral(resourceName: "avatar-4") else {
            completion(.failure(UserError.photoNotExist))
            return
        }
        
        var mUser = MUser(username: username!, email: email, description: description!, sex: sex!, avatarStringURL: "not exist", id: id)
        
        StorageService.shared.upload(photo: avatarImage!) { result in
            switch result {
            
            case .success(let avatarURL):
                mUser.avatarStringURL = avatarURL.absoluteString
                self.usersRef.document(mUser.id).setData(mUser.representation) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(mUser))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        
        
    }
    
    func getUserData(user: User, completion: @escaping (Result<MUser,Error>) -> Void) {
        let docRef = usersRef.document(user.uid)
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                guard let mUser = MUser(document: document) else {
                    completion(.failure(UserError.cannotUnwwrapToMUser))
                    return
                }
                completion(.success(mUser))
            } else {
                print("No info")
                completion(.failure(UserError.cannotGetUserInfo))
            }
        }
    }
}
