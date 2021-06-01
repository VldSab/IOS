//
//  MChat.swift
//  GuTock
//
//  Created by Владимир Гуль on 13.05.2021.
//

import UIKit
import FirebaseFirestore
//data steructure for active chats
struct MChat: Hashable, Decodable {
    var friendUsername: String
    var friendAvatarstringURL: String
    var lastMessageContent: String
    var friendID: String
    
    init(friendUsername: String, friendAvatarstringURL: String, lastMessageContent: String, friendID: String) {
        self.friendUsername = friendUsername
        self.friendAvatarstringURL = friendAvatarstringURL
        self.lastMessageContent = lastMessageContent
        self.friendID = friendID
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let friendUsername = data["friendUsername"] as? String else {return nil}
        guard let friendID = data["friendID"] as? String else {return nil}
        guard let lastMessageContent = data["lastMessage"] as? String else {return nil}
        guard let friendAvatarstringURL = data["friendAvatarstringURL"] as? String else {return nil}

        self.friendUsername = friendUsername
        self.friendID = friendID
        self.lastMessageContent = lastMessageContent
        self.friendAvatarstringURL = friendAvatarstringURL
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(friendID)
    }
    
    static func == (lhs: MChat, rhs: MChat) -> Bool {
        return lhs.friendID == rhs.friendID
    }
    
    var representation: [String : Any] {
        var rep: Dictionary<String, Any> = [:]
        rep["friendUsername"] = friendUsername
        rep["friendAvatarstringURL"] = friendAvatarstringURL
        rep["lastMessage"] = lastMessageContent
        rep["friendID"] = friendID
        return rep
    }
}
