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
    @IBAction func shareButton(_ sender: Any) {
        let shareController = UIActivityViewController(activityItems: [articleText!], applicationActivities: nil)
        present(shareController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = articleText
        textView.font = UIFont(name: "HelveticaNeue", size: 16)
    }


}
