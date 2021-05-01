//
//  UIColor+Extension.swift
//  GuTock
//
//  Created by Владимир Гуль on 30.04.2021.
//

// extension for UIColor for more convenient initialization way
import Foundation
import UIKit

extension UIColor {
    
    static func buttonRed() -> UIColor {
        return #colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1)
    }
    
    static func mainWhite() -> UIColor {
        return #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    static func buttonDark() -> UIColor {
        return #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    }
    
    static func textFieldLight() -> UIColor {
        return #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
    }
}

