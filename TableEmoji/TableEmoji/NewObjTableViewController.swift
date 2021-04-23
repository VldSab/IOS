//
//  NewObjTableViewController.swift
//  TableEmoji
//
//  Created by Владимир Гуль on 23.04.2021.
//

import UIKit

class NewObjTableViewController: UITableViewController {

    @IBOutlet weak var signTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!

    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var obj = Emoji(emoji: "", name: "", description: "", isFavorite: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSaveButtonState()
        updateUI()
    }
    
    private func updateSaveButtonState(){
        let objText = signTF.text ?? ""
        let nameText = nameTF.text ?? ""
        let descriptionText = descriptionTF.text ?? ""
        saveButton.isEnabled = !objText.isEmpty && !nameText.isEmpty && !descriptionText.isEmpty
    }
    
    //if we edit something
    private func updateUI(){
        signTF.text = obj.emoji
        nameTF.text = obj.name
        descriptionTF.text = obj.description
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier ==  "saveSegue" else { return }
        
        let objText = signTF.text ?? ""
        let nameText = nameTF.text ?? ""
        let descriptionText = descriptionTF.text ?? ""
        
        self.obj = Emoji(emoji: objText, name: nameText, description: descriptionText, isFavorite: self.obj.isFavorite)
    }
}
