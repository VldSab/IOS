//
//  WeatherIconManager.swift
//  GuWeather
//
//  Created by Владимир Гуль on 04.06.2021.
//

import UIKit

enum WeatherIconManager: String{
    case ClearSky = "Clear sky"
    case Clouds = "Clouds"
    case Rain = "Rain"
    case Snow = "Snow"
    case Drizzle = "Drizzle"
    case Thunderstorm = "Thunderstorm"
    case Fog = "Fog"
  
   
    case UnpredictedIcon = "unpredicted-icon"
    
    init(rawValue: String) {
        switch rawValue {
        case "Clear sky":
            self = .ClearSky
        case "Fog":
            self = .Fog
        case let thunderstorm where thunderstorm.contains("Thunderstorm"):
            self = .Thunderstorm
        case let rain where rain.contains("Rain") || rain.contains("rain"):
            self = .Rain
        case let snow where snow.contains("Snow") || snow.contains("snow"):
            self = .Snow
        case let clouds where clouds.contains("clouds"):
            self = .Clouds
        case let drizzle where drizzle.contains("Drizzle"):
            self = .Drizzle
        default:
            self = .UnpredictedIcon
        }
    }
}

extension WeatherIconManager {
    var image: UIImage {
        guard let image = UIImage(named: self.rawValue) else {
            return #imageLiteral(resourceName: "Clear sky")
        }
        return image
    }
}
