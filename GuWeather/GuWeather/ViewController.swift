//
//  ViewController.swift
//  GuWeather
//
//  Created by Владимир Гуль on 04.06.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var apparentTemperatureLabel: UILabel!
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let icon = WeatherIconManager.ClearSky.image
        let currentWeather = WeatherStruct(temperature: 10, apparentTemperature: 5, humidity: 30, pressure: 720, icon: icon)
        updateUIWith(currentWeather: currentWeather)
        
        let city = "Moscow"
        let fullURL = URL(string: "https://api.weatherbit.io/v2.0/current?&key=d4e91b8894194baca15472a7427550c6&lang=ru&include=minutely&city=" + "\(city.lowercased())")
        
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        
        let request = URLRequest(url: fullURL!)
        let dataTask = session.dataTask(with: fullURL!) { data, response, error in
            if data == data {
                return
            }
        }
        dataTask.resume()
    }

    func updateUIWith(currentWeather: WeatherStruct) {
        self.imageView.image = currentWeather.icon
        self.pressureLabel.text = currentWeather.pressureString
        self.temperatureLabel.text = currentWeather.temperatureString
        self.apparentTemperatureLabel.text = currentWeather.apparentTemperatureString
        self.humidityLabel.text = currentWeather.humidityString
    }
    
}

