//
//  NewsParser.swift
//  GuNews
//
//  Created by Владимир Гуль on 11.06.2021.
//

import Foundation

final class NewsParser {
    
    let myKey = "7002b72a0efc4e8d81405954e6ccd9d2"
    let newsURLString = "https://newsapi.org/v2/top-headlines?" +
        "country=ru&" +
        "apiKey=7002b72a0efc4e8d81405954e6ccd9d2"
    var newsURL: URL
    var newsRequest: URLRequest
    
    init() {
        self.newsURL = URL(string: newsURLString)!
        self.newsRequest = URLRequest(url: newsURL)
    }
    
    func getNewsJSON(completion: @escaping (Result<Array<[String:Any]>, Error>) -> Void) {
        newsRequest.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let task: URLSessionDataTask = session.dataTask(with: newsRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(ErrorManager.ResponseError))
                return
            }
            guard let data = data  else {
                completion(.failure(error!))
                return
            }
            let statusCode = response.statusCode
            if statusCode == 200 {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let news = json["articles"] as? Array<[String:Any]> {
                            completion(.success(news))
                        }
                    }
                }
                catch {
                    completion(.failure(ErrorManager.JSONConversionFailed))
                    print("Could not convert JSON data into a dictionary.")
                }
            }
        }
        task.resume()
    }
    
    func getArrayOfNews(completion: @escaping (Result<[NewsModel], Error>) -> Void) {
        var article = NewsModel(sourceName: "", title: "", description: "", urlToImageString: "", content: "")
        var newsArray = [NewsModel]()
        self.getNewsJSON { result in
            switch result {
            case .success(let arrayOfNews):
                for elem in arrayOfNews {
                    article = NewsModel(JSON: elem) ?? NewsModel(sourceName: "", title: "", description: "", urlToImageString: "", content: "")
                    newsArray.append(article)
                }
                completion(.success(newsArray))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
