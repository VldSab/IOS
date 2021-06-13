//
//  ArticleViewController.swift
//  GuNews
//
//  Created by Владимир Гуль on 13.06.2021.
//

import UIKit

class ArticleViewController: UIViewController {
    
    var articleText: String?
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = articleText
        textView.font = UIFont(name: "HelveticaNeue", size: 16)
    }


}
