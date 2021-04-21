//
//  ViewController.swift
//  DayFinder
//
//  Created by Владимир Гуль on 16.04.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var monthTF: UITextField!
    @IBOutlet weak var yearTF: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func findDay(_ sender: UIButton) {
        
        guard let day = dateTF.text, let month = monthTF.text, let year = yearTF.text else {
                resultLabel.text = "Unapropriate data"
                return
            }
        
        let calendar = Calendar.current
        //получаю день, месяц и год из text field
        var dateComponents = DateComponents()
        dateComponents.day = Int(day)
        dateComponents.month = Int(month)
        dateComponents.year = Int(year)
        //полная дата
        guard let date = calendar.date(from: dateComponents) else {return}
        //указываем в каком формате хотим получить дату (день недели)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        //получаем день недели
        let weekDay = dateFormatter.string(from: date)
        //выводим
        resultLabel.text = weekDay
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

