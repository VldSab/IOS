//
//  PeopleViewController.swift
//  GuTock
//
//  Created by Владимир Гуль on 05.05.2021.
//

import UIKit

class PeopleViewConteroller: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar() 
    }
    
    //create search bar
    private func setupSearchBar() {
        navigationController?.navigationBar.barTintColor = .mainWhite()
        navigationController?.navigationBar.shadowImage = UIImage()
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        
    }
}




//MARK:- SwiftUI
import SwiftUI
//for working with canvas
struct PeopleVCProvider: PreviewProvider {
    static var previews: some View{
            ContainerView().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = MainTabBarController()
        
        func makeUIViewController(context: Context) -> MainTabBarController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
    
}
