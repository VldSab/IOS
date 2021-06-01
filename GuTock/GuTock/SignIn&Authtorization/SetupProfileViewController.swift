//
//  SetupProfileViewController.swift
//  GuTock
//
//  Created by Владимир Гуль on 03.05.2021.
//

import UIKit
import FirebaseAuth
import SDWebImage

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
    
    //for catching user id and email
    private let currentUser: User
    init(currentUser: User) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
        
        if let username = currentUser.displayName {
            nameTextField.text = username
        }
        if let photoURL = currentUser.photoURL {
            addPhotoView.circleImageView.sd_setImage(with: photoURL, completed: nil)
        }
        //TODO Set google image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        setupHeader()
        letToChatsButton.addTarget(self, action: #selector(letToChatsButtonTapped), for: .touchUpInside)
        addPhotoView.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    
    @objc private func plusButtonTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //create search controller
    private func setupHeader() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()        
    }
    
    @objc private func letToChatsButtonTapped() {
        FirestoreService.shared.saveProfileWith(id: currentUser.uid,
                                                email: currentUser.email!,
                                                username: nameTextField.text,
                                                avatarImage: addPhotoView.circleImageView.image,
                                                description: aboutMeTextField.text,
                                                sex: sexSegmentedController.titleForSegment(at: sexSegmentedController.selectedSegmentIndex)) { result in
            switch result {
            
            case .success(let muser):
                self.showAlert(with: "Success", and: "Go to chats") {
                    let mainTabBarController = MainTabBarController(currentUser: muser)
                    mainTabBarController.modalPresentationStyle = .fullScreen
                    self.present(mainTabBarController, animated: true, completion: nil)
                }
            case .failure(let error):
                self.showAlert(with: "Oh", and: error.localizedDescription)
            }
        }
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
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
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

//MARK:- UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension SetupProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        addPhotoView.circleImageView.image = image
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
        
        let viewController = SetupProfileViewController(currentUser: Auth.auth().currentUser!)
        
        func makeUIViewController(context: Context) -> SetupProfileViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
    
}
