//
//  CollectionViewCell.swift
//  GuNews
//
//  Created by Владимир Гуль on 11.06.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    var articleText: String?
    
   
    override func layoutSubviews() {
       
        self.mainView.layer.cornerRadius = 10
        self.mainView.clipsToBounds = true
        
        self.shadowView.clipsToBounds = false
        self.shadowView.layer.masksToBounds = false
        self.shadowView.layer.cornerRadius = 10
        
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 10
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset = CGSize(width: 2, height: 4)
    }
    
}
