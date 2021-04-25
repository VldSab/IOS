//
//  PhotoViewController.swift
//  PhotoCollection
//
//  Created by Владимир Гуль on 25.04.2021.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var image : UIImage?
    
    @IBOutlet weak var imagePhotoView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePhotoView.image = image
        
    }
    
    @IBAction func shareButton(_ sender: UIButton) {
        let shareController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        present(shareController, animated: true, completion: nil)
    }

}
