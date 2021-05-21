//
//  MChat.swift
//  GuTock
//
//  Created by Владимир Гуль on 13.05.2021.
//

import UIKit

//data steructure for active chats
struct MChat: Hashable, Decodable {
    var username: String
    var userImage: String
    var lastMessage: String
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MChat, rhs: MChat) -> Bool {
        return lhs.id == rhs.id
    }
}
