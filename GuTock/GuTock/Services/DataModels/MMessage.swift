//
//  MMessage.swift
//  GuTock
//
//  Created by Владимир Гуль on 31.05.2021.
//

import UIKit
import FirebaseFirestore
import MessageKit

struct MMessage : Hashable, MessageType {
    
    let content: String
    var sentDate: Date
    let id: String?
    
    var sender: SenderType
    
    var messageId: String {
        return id ?? UUID().uuidString
    }
    
    var kind: MessageKind {
        return .text(content)
    }
    
    init(user: MUser, content: String){
        sender = Sender(senderId: user.id, displayName: user.username)
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
        sender = Sender(senderId: senderID , displayName: senderName)
        self.content = content
    }
    
    var represenation: [String : Any] {
    
        var rep: Dictionary<String, Any> = [
            "created" : sentDate,
            "senderID" : sender.senderId,
            "senderName" : sender.displayName,
            "content" : content
        ]
        return rep
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(messageId)
    }
    
    static func == (lhs: MMessage, rhs: MMessage) -> Bool {
        return lhs.messageId == rhs.messageId
    }
    
}

extension MMessage: Comparable {
    static func < (lhs: MMessage, rhs: MMessage) -> Bool {
        lhs.sentDate < rhs.sentDate
    }
}
