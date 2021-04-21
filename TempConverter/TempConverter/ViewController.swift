//
//  ViewController.swift
//  TempConverter
//
//  Created by Владимир Гуль on 17.04.2021.
//

import UIKit

func CelsToFareng(celsius : Double) -> Int {
    let fareng = round(9/5 * celsius + 32)
    return Int(fareng)
}

class ViewController: UIViewController {
    @IBOutlet weak var celciusLabel: UILabel!
    @IBOutlet weak var farenheitLabel: UILabel!
    @IBOutlet weak var slider: UISlider! {
        didSet{
            slider.maximumValue = 100
            slider.minimumValue = -100
            slider.value = 0
        }
    }
    @IBOutlet weak var backgroundChange: UIImageView!{
        didSet{
            backgroundChange.image = UIImage(named: "summer")
        }
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        let tempCelsius = Int(round(sender.value))
        if tempCelsius >= 0 {
            backgroundChange.image = UIImage(named: "summer")
        } else {
            backgroundChange.image = UIImage(named: "cold1")
        }
        celciusLabel.text = "\(tempCelsius)ºC"
        let tempFareng = CelsToFareng(celsius: Double(tempCelsius))
        farenheitLabel.text = "\(tempFareng)ºF"
    }
    
    
}

