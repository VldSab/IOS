//
//  NewsModel.swift
//  GuNews
//
//  Created by Владимир Гуль on 11.06.2021.
//

import UIKit


//for working with API
struct NewsModel: Decodable {
    let sourceName: String
    let title: String
    let description: String
    let urlToImageString: String
    let content: String 
}

extension NewsModel {
    init?(JSON: [String : Any]) {
        let source = JSON["source"] as? [String:Any] ?? ["name" : "Unknown"]
        self.sourceName = source["name"] as? String ?? "Unknown name"
        self.title = JSON["title"] as? String ?? "No title"
        self.description = JSON["description"] as? String ?? "No description"
        self.urlToImageString = JSON["urlToImage"] as? String ?? "No Image"
        self.content = JSON["content"] as? String ?? "No more content"
        //let weather = JSON["weather"] as? [String: Any] ?? ["weather": ["description": "Clear sky"]]
    }
}
