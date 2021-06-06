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
    
    lazy var weatherManager = APIWeatherManager(city: "Moscow")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.fetchCurrentWeatherWith(city: weatherManager.city) { result in
            switch result {
            case .success(let currentWeather):
                self.updateUIWith(currentWeather: currentWeather)
            case .failure(let error):
                self.showAlert(with: "Error", and: error.localizedDescription)
            }
        }
    
    }

    func updateUIWith(currentWeather: WeatherStruct) {
        self.imageView.image = currentWeather.icon
        self.pressureLabel.text = currentWeather.pressureString
        self.temperatureLabel.text = currentWeather.temperatureString
        self.apparentTemperatureLabel.text = currentWeather.apparentTemperatureString
        self.humidityLabel.text = currentWeather.humidityString
    }
    
}

