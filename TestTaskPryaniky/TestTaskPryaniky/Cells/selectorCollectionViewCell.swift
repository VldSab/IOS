//
//  selectorCollectionViewCell.swift
//  TestTaskPryaniky
//
//  Created by Владимир Гуль on 25.07.2021.
//

import UIKit

class selectorCollectionViewCell:
    UICollectionViewCell {
    
    @IBOutlet weak var selectorLabel: UILabel!
    @IBOutlet weak var selectorFirstButton: UIButton!
    @IBOutlet weak var selectorSecondButton: UIButton!
    @IBOutlet weak var selectorThirdButton: UIButton!
    
    override func layoutSubviews() {
        self.backgroundColor = .systemTeal
        self.layer.cornerRadius = 24
        self.contentView.clipsToBounds = false
    }
}
