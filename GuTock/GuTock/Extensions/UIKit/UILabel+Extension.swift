//
//  UILabel+Extension.swift
//  GuTock
//
//  Created by Владимир Гуль on 30.04.2021.
//

import UIKit

// extension for UILabel for more convenient initialization way
extension UILabel {
    convenience init(text: String, font: UIFont? = .avenir20()){
        self.init()
        self.text = text
        self.font = font
    }
}
