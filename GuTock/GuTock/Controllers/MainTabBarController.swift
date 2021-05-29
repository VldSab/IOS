//
//  MainTabBarController.swift
//  GuTock
//
//  Created by Владимир Гуль on 05.05.2021.
//

import UIKit
import FirebaseAuth

class MainTabBarController: UITabBarController {
    
    private let currentUser: MUser
    init(currentUser: MUser = MUser(username: "", email: "", description: "", sex: "", avatarStringURL: "", id: "")){
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //controllers to tabBar
        let listViewController = ListViewController(currentUser: currentUser)
        let peopleViewController = PeopleViewController(currentUser: currentUser)
        let setupProfileController = SetupProfileViewController(currentUser: Auth.auth().currentUser!)
        
        
        tabBar.tintColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        
        //image for controllest in tabBar
        let configurationBold = UIImage.SymbolConfiguration(weight: .medium)
        let conversationImage = UIImage(systemName: "bubble.left.and.bubble.right", withConfiguration: configurationBold)!
        let peopleImage = UIImage(systemName: "person.2", withConfiguration: configurationBold)! //they are always exists
        let setupProfileImage = UIImage(systemName: "gearshape.fill", withConfiguration: configurationBold)!
        
        viewControllers = [
            generateNAvigationController(rootViewController: peopleViewController, title: "People", image: peopleImage),
            generateNAvigationController(rootViewController: listViewController, title: "Conversations", image: conversationImage),
            generateNAvigationController(rootViewController: setupProfileController, title: "Setup Profile", image: setupProfileImage)
        ]
        
    }
    private func generateNAvigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController{
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        return navigationController
    }
}
