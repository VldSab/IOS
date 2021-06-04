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
        return "\(Int(pressure)) mm"
    }
    
}
