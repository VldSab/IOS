//
//  FilmStruct.swift
//  PhotoCollection
//
//  Created by Владимир Гуль on 09.06.2021.
//

import UIKit

//for working with The Dark Sky Forecast API
struct FilmStruct: Decodable {
    let title: String
    let ratingIMDB: Double
    let description: String
    let posterURLString: String
}

extension FilmStruct {
    init?(JSON: [String : Any]) {
        self.title = JSON["title"] as? String ?? "No title"
        self.ratingIMDB = JSON["rating_imdb"] as? Double ?? 0
        self.description = JSON["description"] as? String ?? "No description"
        self.posterURLString = JSON["poster"] as? String ?? "No description"
        //let weather = JSON["weather"] as? [String: Any] ?? ["weather": ["description": "Clear sky"]]
    }
}

