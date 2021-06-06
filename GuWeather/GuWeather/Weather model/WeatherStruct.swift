//
//  WeatherStruct.swift
//  GuWeather
//
//  Created by Владимир Гуль on 04.06.2021.
//

import UIKit

//for working with The Dark Sky Forecast API
struct WeatherStruct {
    let temperature: Double
    let apparentTemperature: Double
    let humidity: Double
    let pressure: Double
    let icon: UIImage
}

extension WeatherStruct {
    
    var temperatureString: String {
        return "\(Int(temperature))˚C"
    }
    
    var apparentTemperatureString: String {
        return "Feels like \(Int(apparentTemperature))˚C"
    }
    
    var humidityString: String {
        return "\(Int(humidity))%"
    }
    
    var pressureString: String {
        //convert mb to mm Hg
        return "\(Int(pressure * 0.75006)) mm"
    }
    
}

extension WeatherStruct: JSONDecodable {
    init?(JSON: [String : AnyObject]) {
        self.temperature = JSON["temp"] as? Double ?? 0
        self.apparentTemperature = JSON["app_temp"] as? Double ?? 0
        self.humidity = JSON["rh"] as? Double ?? 0
        self.pressure = JSON["pres"] as? Double ?? 0
        let weather = JSON["weather"] as? [String: Any] ?? ["weather": ["description": "Clear sky"]]
        let iconString = weather["description"] as? String ?? "Clear sky"
        self.icon = WeatherIconManager(rawValue: iconString).image
    }
}
