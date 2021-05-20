//
//  ProfileViewController.swift
//  GuTock
//
//  Created by Владимир Гуль on 15.05.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let containerView = UIView()
    let imageView = UIImageView(image: #imageLiteral(resourceName: "July"), contentMode: .scaleAspectFill)
    let nameLabel = UILabel(text: "July", font: .laoSangamMN26())
    let aboutMeLabel = UILabel(text: "I love the genius Vladimir, he is the best", font: .laoSangamMN20())
    var myTextField = InsertableTextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        customizeElements()
    }
    
    //its not customization, and I will fix it later
    private func customizeElements(){
        if let button = myTextField.rightView as? UIButton {
            button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        }
    }
    
    @objc private func sendMessage() {
        print(#function)
    }
    
}

//MARK:- Constraints
extension ProfileViewController {
    
    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .mainWhite()
        containerView.layer.cornerRadius = 30
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutMeLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutMeLabel.numberOfLines = 0
        myTextField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        view.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(aboutMeLabel)
        containerView.addSubview(myTextField)
        
        
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
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30),
        ])
        
        NSLayoutConstraint.activate([
            aboutMeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            aboutMeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),
            aboutMeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30),
        ])
                
        NSLayoutConstraint.activate([
            myTextField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -60),
            myTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),
            myTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30),
            myTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
}


//MARK:- SwiftUI
import SwiftUI
//for working with canvas
struct ProfileVCProvider: PreviewProvider {
    static var previews: some View{
            ContainerView().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = ProfileViewController()
        
        func makeUIViewController(context: Context) -> ProfileViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
    
}
