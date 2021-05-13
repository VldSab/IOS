//
//  MUser.swift
//  GuTock
//
//  Created by Владимир Гуль on 13.05.2021.
//

import Foundation

//data steructure for active chats
struct MUser: Hashable, Decodable {
    var username: String
    var avatarStringURL: String
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MUser, rhs: MUser) -> Bool {
        return lhs.id == rhs.id
    }
}
