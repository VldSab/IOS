//
//  APIManager.swift
//  GuWeather
//
//  Created by Владимир Гуль on 05.06.2021.
//

import Foundation

typealias JSONTask = URLSessionDataTask
typealias JSONCompletionHandler = ([String: AnyObject]?, HTTPURLResponse?, Error?)->Void

protocol APIManager {
    var sessionConfiguration: URLSessionConfiguration { get }
    var session: URLSession { get }
    
    func JSONTaskWith(request: URLRequest, completion: @escaping JSONCompletionHandler) -> JSONTask
    func fetch<T: JSONDecodable>(request: URLRequest, parse: @escaping ([String: AnyObject]) -> T?, completion: @escaping (Result<T, Error>) -> Void)
}

protocol JSONDecodable {
    init?(JSON: [String: AnyObject])
}

extension APIManager {
    func JSONTaskWith(request: URLRequest, completion: @escaping JSONCompletionHandler) -> JSONTask {
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                let userInfo = [
                    NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Response", comment: "")
                ]
                let error = NSError(domain: WeatherNetworkingErrorDomain, code: MissingHTTPResponseError, userInfo: userInfo)
                completion(nil, nil, error)
                return
            }
            
            if data == nil {
                if let error = error {
                    completion(nil, response, error)
                }
            } else {
                switch response.statusCode {
                case 200:
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                        completion(json, response, nil)
                    } catch let error as NSError {
                        completion(nil, response, error)
                    }
                default:
                    print("We have got response with \(response.statusCode)")
                }
            }
            
        }
        return dataTask
    }
    
    func fetch<T: JSONDecodable>(request: URLRequest, parse: @escaping ([String: AnyObject]) -> T?, completion: @escaping (Result<T, Error>) -> Void) {
        let dataTask = JSONTaskWith(request: request) { json, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                let json = json!
                
                if let value = parse(json) {
                    completion(.success(value))
                } else {
                    let error = NSError(domain: "Cant parse", code: UnexpectedError, userInfo: nil)
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
}


