//
//  ChatRequestViewController.swift
//  GuTock
//
//  Created by Владимир Гуль on 19.05.2021.
//

import UIKit

class ChatRequestViewController: UIViewController {
    
    let containerView = UIView()
    let imageView = UIImageView(image: #imageLiteral(resourceName: "July"), contentMode: .scaleAspectFill)
    let nameLabel = UILabel(text: "July", font: .laoSangamMN26())
    let descriptionLabel = UILabel(text: "", font: .laoSangamMN20())
    let buttonAccept = UIButton(title: "ACCEPT", titleColor: .white, backgroundColor: .systemBlue, isShadow: true, cornerRadius: 10)
    let buttonDeny = UIButton(title: "Deny", titleColor: .mainWhite(), backgroundColor: .mainWhite(), isShadow: true, cornerRadius: 10)
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        if let text = nameLabel.text {
            descriptionLabel.text = "\(text) wants to chat with you!"
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.buttonAccept.applyGradients(cornerRadius: 10)
        self.buttonDeny.applyGradientsRed(cornerRadius: 10)
    }
    
}

//MARK:- Constraints
extension ChatRequestViewController {
 
    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .mainWhite()
        containerView.layer.cornerRadius = 30
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonAccept.translatesAutoresizingMaskIntoConstraints = false
     
        buttonDeny.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(imageView)
        view.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(buttonAccept)
        containerView.addSubview(buttonDeny)
        
        
        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 206)
            
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30)
        ])
        
        
        let buttonSize = (view.frame.size.width - 3 * 30) / 2
        NSLayoutConstraint.activate([
            buttonAccept.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            buttonAccept.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),
            buttonAccept.widthAnchor.constraint(equalToConstant: buttonSize),
            buttonAccept.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            buttonDeny.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            buttonDeny.leadingAnchor.constraint(equalTo: buttonAccept.trailingAnchor, constant: 30),
            buttonDeny.widthAnchor.constraint(equalToConstant: buttonSize),
            buttonDeny.heightAnchor.constraint(equalToConstant: 50)
        ])
        
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
