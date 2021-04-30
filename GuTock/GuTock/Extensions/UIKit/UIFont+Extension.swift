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
}
