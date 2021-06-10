//
//  KinopoiskParser.swift
//  PhotoCollection
//
//  Created by Владимир Гуль on 09.06.2021.
//

import UIKit
final class KinopoiskParser {
    
    let urlTest: URL
    var request: URLRequest
    init(){
        self.urlTest = URL(string: "https://api.kinopoisk.cloud/movies/all/page/666/token/a854637a35acb64008f04e06b14e275e")!
        self.request = URLRequest(url: urlTest)
    }

    func getJSON(completion: @escaping (Result<Array<[String:Any]> , Error>) -> Void) {
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        
        let task : URLSessionDataTask = session.dataTask(with: request) { (data, response, error) in
            
            let statusCode = (response as! HTTPURLResponse).statusCode
            if statusCode == 200{
                guard let dataResponse = data, error == nil else {
                    completion(.failure(error!))
                    return
                }
                do {
                    if let json = try JSONSerialization.jsonObject(with: dataResponse, options: []) as? [String:Any] {
                        if let movies = json["movies"] as? Array<[String:Any]> {
                            completion(.success(movies))
                        }
                    }
                }
                catch {
                    print("Could not convert JSON data into a dictionary.")
                    
                }
            }
        }
        task.resume()
    }
    
    func getArrayOfFilms(completion: @escaping (Result<[FilmStruct], Error>) -> Void) {
        var film = FilmStruct(title: "none", ratingIMDB: 0, description: "none", posterURLString: "none")
        var filmsArray = [FilmStruct]()
        self.getJSON { result in
            switch result {
            case .success(let arrayOfFilms):
                for movie in arrayOfFilms {
                    film = FilmStruct(JSON: movie) ?? FilmStruct(title: "none", ratingIMDB: 0, description: "none", posterURLString: "none")
                    filmsArray.append(film)
                }
                completion(.success(filmsArray))
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
    }

}
