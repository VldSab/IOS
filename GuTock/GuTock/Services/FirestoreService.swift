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
    
    func saveProfileWith(id: String, email: String, username: String?, avatarImageString: String?, description: String?, sex: String?,
                         completion: @escaping (Result<MUser,Error>) -> Void) {
        
        guard Validators.isFilled(username: username, description: description, sex: sex) else {
            completion(.failure(UserError.notFilled))
            return
        }
        
        let mUser = MUser(username: username!, email: email, description: description!, sex: sex!, avatarStringURL: "not exist", id: id)
        
        self.usersRef.document(mUser.id).setData(mUser.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(mUser))
            }
        }
        
    }
}
