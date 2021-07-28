//
//  hzCollectionViewCell.swift
//  TestTaskPryaniky
//
//  Created by Владимир Гуль on 25.07.2021.
//

import UIKit

class hzCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var textHZLabel: UILabel!
    
    
    override func layoutSubviews() {
        self.backgroundColor = .systemGray2
        self.layer.cornerRadius = 24
        self.contentView.clipsToBounds = false
    }
}
