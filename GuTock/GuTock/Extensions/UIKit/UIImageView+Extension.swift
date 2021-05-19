//
//  UIImageView+Extension.swift
//  GuTock
//
//  Created by Владимир Гуль on 30.04.2021.
//

// extension for ImageView for more convenient initialization way
import UIKit

extension UIImageView {
    convenience init(image: UIImage?, contentMode: UIView.ContentMode){
        self.init()
        self.image = image
        self.contentMode = contentMode
    }
}


extension UIImageView {
    func setupColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
