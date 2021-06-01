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
    
    var currentUser : MUser!
    
    private var waitingChatsRef: CollectionReference {
        return db.collection(["users", currentUser.id, "waitingChats"].joined(separator: "/"))
    }
    
    private var activeChatsRef: CollectionReference {
        return db.collection(["users", currentUser.id, "activeChats"].joined(separator: "/"))
    }
    
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
                self.currentUser = mUser
                completion(.success(mUser))
            } else {
                print("No info")
                completion(.failure(UserError.cannotGetUserInfo))
            }
        }
    }
    
    func createWaitingChat(message: String, reciever: MUser, completion: @escaping (Result<Void,Error>) -> Void)  {
        let reference = db.collection(["users", reciever.id, "waitingChats"].joined(separator: "/"))
        let messageRef = reference.document(self.currentUser.id).collection("messages")
        
        let message = MMessage(user: currentUser, content: message)
        let chat =  MChat(friendUsername: currentUser.username,
                          friendAvatarstringURL: currentUser.avatarStringURL,
                          lastMessageContent: message.content,
                          friendID: currentUser.id)
        
        reference.document(currentUser.id).setData(chat.representation) { error in
            if let error = error {
                completion(.failure(error))
            }
            messageRef.addDocument(data: message.represenation) { error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(Void()))
            }
        }
    }
    
    func deleteWaitingChat(chat: MChat,  completion: @escaping (Result<Void,Error>) -> Void) {
        waitingChatsRef.document(chat.friendID).delete { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            self.deleteMessages(chat: chat, completion: completion)
        }
    }
    
    func deleteMessages(chat: MChat, completion: @escaping (Result<Void, Error>) -> Void) {
        let reference = waitingChatsRef.document(chat.friendID).collection("messages")
        getWaitingChatMessages(chat: chat) { result in
            switch result {
            
            case .success(let messages):
                for message in messages {
                    guard let documentID = message.id else {
                        return
                    }
                    let messageRef = reference.document(documentID)
                    messageRef.delete { error in
                        if let error = error {
                            completion(.failure(error))
                            return
                        }
                        completion(.success(Void()))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getWaitingChatMessages(chat: MChat, completion: @escaping (Result<[MMessage], Error>) -> Void) {
        let reference = waitingChatsRef.document(chat.friendID).collection("messages")
        var messages = [MMessage]()
        reference.getDocuments { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
            }
            for document in querySnapshot!.documents {
                guard let message = MMessage(document: document) else {
                    return
                }
                messages.append(message)
            }
            completion(.success(messages))
        }
    }
    
    func changeToActive(chat: MChat, completion: @escaping (Result<Void, Error>) -> Void) {
        getWaitingChatMessages(chat: chat) { result in
            switch result {
            case .success(let messages):
                self.deleteWaitingChat(chat: chat) { result in
                    switch result {
                    case .success():
                        self.createActiveChat(chat: chat, messages: messages) { result in
                            switch result {
                            case .success():
                                completion(.success(Void()))
                            case .failure(let error):
                                completion(.failure(error))
                            }
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createActiveChat(chat: MChat, messages: [MMessage], completion: @escaping (Result<Void,Error>) -> Void)  {
        let messageRef = activeChatsRef.document(chat.friendID).collection("messages")
        activeChatsRef.document(chat.friendID).setData(chat.representation) { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            for message in messages {
                messageRef.addDocument(data: message.represenation) { error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    completion(.success(Void()))
                }
            }
            
        }
    }
}
