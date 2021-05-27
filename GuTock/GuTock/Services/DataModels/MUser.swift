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
    var email: String
    var description: String
    var sex: String
    var avatarStringURL: String
    var id: String 
    
    var representation: [String : Any] {
        var rep: Dictionary<String, Any> = [:]
        rep["username"] = username
        rep["sex"] = sex
        rep["email"] = email
        rep["description"] = description
        rep["avatarStringURL"] = avatarStringURL
        rep["uid"] = id
        return rep
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func contains(text: String?) -> Bool {
        guard let filter = text else {
            return true
        }
        if filter.isEmpty {
            return true
        }
        let lowercasedFilter = filter.lowercased()
        let isContains = username.lowercased().contains(lowercasedFilter)
        return isContains
    }
    
    static func == (lhs: MUser, rhs: MUser) -> Bool {
        return lhs.id == rhs.id
    }
}
