//
//  EmojiViewControllerTableViewController.swift
//  TableEmoji
//
//  Created by Владимир Гуль on 21.04.2021.
//

import UIKit

class EmojiViewControllerTableViewController: UITableViewController {
    
    //this object we will use as initializer for start rows scrin
    var objects = [
        Emoji(emoji: "🥰", name: "Love", description: "Love Is", isFavorite: false),
        Emoji(emoji: "😇", name: "Angel", description: "All dogs go to heaven", isFavorite: false),
        Emoji(emoji: "😡", name: "Angry", description: "Do not do it again", isFavorite: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //scrib title
        self.title = "Emoji Table"
        //edit button on the left
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    //for "save' button
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        //check identifier
        guard segue.identifier == "saveSegue" else { return }
        //where from we came
        let sourceVC = segue.source as! NewObjTableViewController
        //get our object from NewObjTableViewController
        let obj = sourceVC.obj
        
        if  let indexOfSelectedRow = tableView.indexPathForSelectedRow{
            //edit 
            objects[indexOfSelectedRow.row] = obj
            tableView.reloadRows(at: [indexOfSelectedRow], with: .fade)
        } else {
            //create new
            //index == size because we push new element
            let newIndexPath = IndexPath(row: self.objects.count, section: 0)
            objects.append(obj)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editObject" else { return }
        let editObjIndexPath = tableView.indexPathForSelectedRow!
        let obj = objects[editObjIndexPath.row]
        let navigationVC = segue.destination as! UINavigationController
        let newObjVC = navigationVC.topViewController as! NewObjTableViewController
        newObjVC.obj = obj
        newObjVC.title = "Edit"
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
  
    override func tableView(_ tableView: UITableView,  cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as! EmojiTableViewCell
        let object = objects[indexPath.row]
        //fill cell with objects object
        cell.set(object: object)
        return cell
     }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        //when tap edit or slide left, we see delete button
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            //just delet row and element of objects array
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //remove row and save to movedEmoji
        let movedEmoji = objects.remove(at: sourceIndexPath.row)
        //paste into new place
        objects.insert(movedEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at: indexPath)
        let favorite = favoriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done, favorite])
    }

    //with "done" we remove like with delete
    func doneAction(at indexPath: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .destructive, title: "Done") { (action, view, completion) in
            self.objects.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: "checkmark.circle")
        return action
    }
    
    func favoriteAction(at indexPath: IndexPath) -> UIContextualAction {
        var state = self.objects[indexPath.row].isFavorite
        //create action for like
        let action = UIContextualAction(style: .normal, title: "Favorite") { (action, view, completion) in
            //if state is "like" and we tapped then state becomes "unlike" etc
            state = state ? false : true
            //refresh objects
            self.objects[indexPath.row].isFavorite = state
            completion(true)
        }
        //purple with like and gray without like
        action.backgroundColor = state ? .systemPurple : .systemGray
        action.image = UIImage(systemName: "heart")
        return action
    }
}
