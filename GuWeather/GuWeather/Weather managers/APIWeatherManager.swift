//
//  APIWeatherManager.swift
//  GuWeather
//
//  Created by Владимир Гуль on 05.06.2021.
//

import Foundation

final class APIWeatherManager : APIManager {
    var sessionConfiguration: URLSessionConfiguration
    lazy var session: URLSession = {
        return URLSession(configuration: self.sessionConfiguration)
    }()
    //let apiKey: String
    let city: String
    
    enum ForecastType: FinalURLPoint {
        case withCity( city: String)
    
        var fullURL: URL {
            switch self {
            case .withCity(let city):
                let baseURLString = "https://api.weatherbit.io/v2.0/current?&key=d4e91b8894194baca15472a7427550c6&include=minutely&city="
                let fullURL = URL(string: baseURLString + city.lowercased())!
                return fullURL
            }
          
        }
        
        var request: URLRequest {
            return URLRequest(url: fullURL)
        }
        
        
    }
    
    init(sessionConfiguration: URLSessionConfiguration, city: String) {
        self.sessionConfiguration = sessionConfiguration
        self.city = city
    }
    
    convenience init(city: String) {
        self.init(sessionConfiguration: URLSessionConfiguration.default, city: city)
    }
    
    func fetchCurrentWeatherWith(city: String, completion: @escaping (Result<WeatherStruct, Error>) -> Void) {
        let request = ForecastType.withCity(city: city).request
      
      fetch(request: request, parse: { (json) -> WeatherStruct? in
        if let dictionary = json["data"]![0] as? [String: AnyObject] {
          return WeatherStruct(JSON: dictionary)
        } else {
          return nil
        }
        
      }, completion: completion)
    }
    
}
