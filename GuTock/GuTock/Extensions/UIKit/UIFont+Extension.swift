//
//  UIFont+Extension.swift
//  GuTock
//
//  Created by Владимир Гуль on 29.04.2021.
//

import Foundation
import UIKit

// extension for UIFont for more convenient initialization way
extension UIFont{
    static func avenir20() -> UIFont? {
        return UIFont.init(name: "avenir", size: 20)
    }
    
    static func avenir26() -> UIFont? {
        return UIFont.init(name: "avenir", size: 26)
    }
    
    static func laoSangamMN20() -> UIFont? {
        return UIFont.init(name: "Lao Sangam MN", size: 20)
    }
    
    static func laoSangamMN18() -> UIFont? {
        return UIFont.init(name: "Lao Sangam MN", size: 18)
    }
}
