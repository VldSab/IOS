//
//  MUser.swift
//  GuTock
//
//  Created by Владимир Гуль on 13.05.2021.
//

import Foundation
import FirebaseFirestore
//data steructure for active chats
struct MUser: Hashable, Decodable {
    var username: String
    var email: String
    var description: String
    var sex: String
    var avatarStringURL: String
    var id: String 
    
    init(username: String, email: String, description: String, sex: String, avatarStringURL: String, id: String) {
        self.username = username
        self.id = id
        self.email = email
        self.description = description
        self.sex = sex
        self.avatarStringURL = avatarStringURL
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else {
            return nil
        }
        guard let username = data["username"] as? String else {return nil}
        guard let id = data["uid"] as? String else {return nil}
        guard let email = data["email"] as? String else {return nil}
        guard let description = data["description"] as? String else {return nil}
        guard let sex = data["sex"] as? String else {return nil}
        guard let avatarStringURL = data["avatarStringURL"] as? String else {return nil}
        
        self.username = username
        self.id = id
        self.email = email
        self.description = description
        self.sex = sex
        self.avatarStringURL = avatarStringURL
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let username = data["username"] as? String else {return nil}
        guard let id = data["uid"] as? String else {return nil}
        guard let email = data["email"] as? String else {return nil}
        guard let description = data["description"] as? String else {return nil}
        guard let sex = data["sex"] as? String else {return nil}
        guard let avatarStringURL = data["avatarStringURL"] as? String else {return nil}
        
        self.username = username
        self.id = id
        self.email = email
        self.description = description
        self.sex = sex
        self.avatarStringURL = avatarStringURL
    }
    
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
