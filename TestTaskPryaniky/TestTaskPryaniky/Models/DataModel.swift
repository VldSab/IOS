//
//  DataModel.swift
//  TestTaskPryaniky
//
//  Created by Владимир Гуль on 25.07.2021.
//

import Foundation

struct DataModel {
    let name: String
    let text: String?
    let URL: String?
    let selectedId: Int?
    let variants: Array<[String: Any]>?
    
    init() {
        self.name = ""
        self.text = ""
        self.URL = ""
        self.selectedId = 0
        self.variants = [["":""]]
    }
}

extension DataModel {
    init?(JSON: [String:Any]) {
        self.name = JSON["name"] as? String ?? "No name"
        let nextData = JSON["data"] as? [String: Any]
        self.text = nextData?["text"] as? String
        self.URL = nextData?["url"] as? String
        self.selectedId = nextData?["selectedId"] as? Int
        self.variants = nextData?["variants"] as? Array<[String:Any]>
    }
}
