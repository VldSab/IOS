//
//  pictureCollectionViewCell.swift
//  TestTaskPryaniky
//
//  Created by Владимир Гуль on 25.07.2021.
//

import UIKit

class pictureCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var textPictureLabel: UILabel!
    @IBOutlet weak var imageViewImage: UIImageView!
    
    
    override func layoutSubviews() {
        self.backgroundColor = .systemPurple
        self.layer.cornerRadius = 24
        self.contentView.clipsToBounds = false
    }
}
