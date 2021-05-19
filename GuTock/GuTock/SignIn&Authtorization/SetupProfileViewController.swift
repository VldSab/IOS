//
//  SetupProfileViewController.swift
//  GuTock
//
//  Created by Владимир Гуль on 03.05.2021.
//

import UIKit

class SetupProfileViewController: UIViewController {
    
    let welcomeLabel = UILabel(text: "Setup Profile", font: .avenir26())
    let addPhotoView = AddPhotoView()
    
    //labels
    let nameLabel = UILabel(text: "Full name", font: .avenir20())
    let aboutMeLabel = UILabel(text: "About me", font: .avenir20())
    let sexLabel = UILabel(text: "Sex", font: .avenir20())
    
    //text fields
    let nameTextField = OneLineTextField(font: .avenir20())
    let aboutMeTextField = OneLineTextField(font: .avenir20())
    
    //segmented conteroller
    let sexSegmentedController = UISegmentedControl(first: "Male", second: "Female")
    
    //button
    let letToChatsButton = UIButton(title: "Go to chats", titleColor: .white, backgroundColor: .buttonDark(), isShadow: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
    }
    
}

//MARK:- Setup constraints
extension SetupProfileViewController {
    private func setupConstraints() {
        //addPhotoView.translatesAutoresizingMaskIntoConstraints = false
        //view.addSubview(addPhotoView)
        
        //stack for name fields
        let nameStackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
        nameStackView.axis = .vertical
        nameStackView.spacing = 0
        
        //stack for "about me"
        let aboutMeStackView = UIStackView(arrangedSubviews: [aboutMeLabel, aboutMeTextField])
        aboutMeStackView.axis = .vertical
        aboutMeStackView.spacing = 0
        
        //stack for sex
        let sexStackView = UIStackView(arrangedSubviews: [sexLabel, sexSegmentedController])
        sexStackView.axis = .vertical
        sexStackView.spacing = 0
        
        letToChatsButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        //final stack
        let stackView = UIStackView(arrangedSubviews: [nameStackView,
                                                       aboutMeStackView,
                                                       sexStackView,
                                                       letToChatsButton])
        
        stackView.axis = .vertical
        stackView.spacing = 40
        
        view.addSubview(welcomeLabel)
        view.addSubview(stackView)
        view.addSubview(addPhotoView)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addPhotoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            addPhotoView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 60),
            addPhotoView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo:addPhotoView.bottomAnchor, constant: 60),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}

//MARK:- SwiftUI
import SwiftUI
//for working with canvas
struct SetupProfileVCProvider: PreviewProvider {
    static var previews: some View {
        Group {
            ContainerView().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = SetupProfileViewController()
        
        func makeUIViewController(context: Context) -> SetupProfileViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
    
}
