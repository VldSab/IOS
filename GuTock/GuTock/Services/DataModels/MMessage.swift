//
//  MMessage.swift
//  GuTock
//
//  Created by Владимир Гуль on 31.05.2021.
//

import UIKit
import FirebaseFirestore

struct MMessage : Hashable {
    let content: String
    let senderID: String
    let senderUsername: String
    var sentDate: Date
    let id: String?
    
    init(user: MUser, content: String){
        senderID = user.id
        senderUsername = user.username
        sentDate = Date()
        id = nil
        self.content = content
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let sentDate = data["created"] as? Timestamp else {
            return nil
        }
        guard let senderID = data["senderID"] as? String else {
            return nil
        }
        guard let senderName = data["senderName"] as? String else {
            return nil
        }
        guard let content = data["content"] as? String else {
            return nil
        }
        
        self.id = document.documentID
        self.sentDate = sentDate.dateValue()
        self.senderID = senderID
        self.senderUsername = senderName
        self.content = content
    }
    
    var represenation: [String : Any] {
    
        var rep: Dictionary<String, Any> = [
            "created" : sentDate,
            "senderID" : senderID,
            "senderName" : senderUsername,
            "content" : content
        ]
        return rep
    }
    
}
