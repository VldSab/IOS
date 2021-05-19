//
//  ChatRequestViewController.swift
//  GuTock
//
//  Created by Владимир Гуль on 19.05.2021.
//

import UIKit

class ChatRequestViewController: UIViewController {
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}


//MARK:- SwiftUI
import SwiftUI
//for working with canvas
struct ChatRequestVCProvider: PreviewProvider {
    static var previews: some View{
            ContainerView().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = ChatRequestViewController()
        
        func makeUIViewController(context: Context) -> ChatRequestViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
    
}
