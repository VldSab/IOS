//
//  DataParser.swift
//  TestTaskPryaniky
//
//  Created by Владимир Гуль on 25.07.2021.
//

import Foundation
import Alamofire

final class DataParser {
    
    public static var dataParser = DataParser()
    
    let requestURLString = "https://pryaniky.com/static/json/sample.json"
    
    func fetchData(completion: @escaping (Result<(Array<[String:Any]>, [String]), Error>) -> Void) {
        
        AF.request(requestURLString).validate().response { response in
            
            if let error = response.error {
                completion(.failure(error))
                return
            }
            guard let data = response.value else {
                completion(.failure(ErrorManager.NoDataRecived))
                return
            }
            guard let data = data else {
                completion(.failure(ErrorManager.NoDataRecived))
                return
            }
            
            let statusCode = response.response?.statusCode
            if statusCode == 200 {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let pryanikData = json["data"] as? Array<[String: Any]>, let viewArrayPryaniky = json["view"] as? [String]  {
                            completion(.success((pryanikData, viewArrayPryaniky)))
                        }
                        if let viewArrayPryaniky = json["view"] as? [String] {
                            
                        }
                    }
                } catch {
                    completion(.failure(ErrorManager.JSONConversionFailed))
                    print("Could not convert JSON data into a dictionary.")
                }
            }
        }
        
    }
    
    func getArrayOfData(completion: @escaping (Result<([DataModel],[String]), Error>) -> Void) {
        var dataItem = DataModel()
        var dataItemsArray = [DataModel]()
        self.fetchData { result in
            switch result {
            case .success(let dataArray):
                for elem in dataArray.0 {
                    dataItem = DataModel(JSON: elem) ?? DataModel()
                    dataItemsArray.append(dataItem)
                }
                completion(.success((dataItemsArray, dataArray.1)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}
