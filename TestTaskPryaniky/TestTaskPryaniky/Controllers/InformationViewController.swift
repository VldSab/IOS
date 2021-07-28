//
//  InformationViewController.swift
//  TestTaskPryaniky
//
//  Created by Владимир Гуль on 27.07.2021.
//

import UIKit

class InformationViewController: UIViewController {

    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var informationImage: UIImageView!
    
    var textForInformationLabel = String()
    var image = UIImageView()
    
    var isImageHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        informationLabel.text = textForInformationLabel
        informationImage.image = image.image
        informationImage.isHidden = isImageHidden
    }
}
