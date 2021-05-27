//
//  SignUpViewController.swift
//  GuTock
//
//  Created by Владимир Гуль on 01.05.2021.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let welcomeLabel = UILabel(text: "Good to see you!", font: .avenir26())
    
    //labeles
    let emailLabel = UILabel(text: "Email")
    let passwordLabel = UILabel(text: "Password")
    let confirmPasswordLabel = UILabel(text: "Confirm password")
    let alreadyOnboardLabel = UILabel(text: "Already onboard?")
    
    //custom text fields
    let emailTextField = OneLineTextField(font: .avenir20())
    let passwordTextField = OneLineTextField(font: .avenir20())
    let confirmPasswordTextField = OneLineTextField(font: .avenir20())
    
    //buttons
    let signUpButton = UIButton(title: "Sign Up", titleColor: .white, backgroundColor: .buttonDark(), isShadow: false)
    let loginButton: UIButton = {
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.buttonRed(), for: .normal)
        loginButton.titleLabel?.font = .avenir20()
        return loginButton
    }()
    
    weak var delegate: AuthNavigatingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        
        //events click button
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc private func signUpButtonTapped() {
        print(#function)
        AuthService.shared.register(email: emailTextField.text, password: passwordTextField.text, confirmPassword: confirmPasswordTextField.text) { result in
            switch result{
            case .success(let user):
                self.showAlert(with: "Fine", and: "You are on the board") {
                    self.present(SetupProfileViewController(currentUser: user), animated: true, completion: nil)
                }
            case .failure(let error):
                self.showAlert(with: "Oh", and: error.localizedDescription)
            }
        }
    }
    
    @objc private func loginButtonTapped() {
        self.dismiss(animated: true) {
            self.delegate?.toLoginVC()
        }
    }
    
}

//MARK:- Setup Constraints
extension SignUpViewController {
    private func setupConstraints() {
        //emailLabel + textField
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField])
        emailStackView.axis = .vertical
        emailStackView.spacing = 0
        
        //passwordLabel + textField
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField])
        passwordStackView.axis = .vertical
        passwordStackView.spacing = 0
        
        //confirmPasswordLabel + textField
        let confirmPasswordStackView = UIStackView(arrangedSubviews: [confirmPasswordLabel, confirmPasswordTextField])
        confirmPasswordStackView.axis = .vertical
        confirmPasswordStackView.spacing = 0
        
        //setup height of button
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        //make general stackView for fields
        let stackView = UIStackView(arrangedSubviews: [emailStackView,
                                                       passwordStackView,
                                                       confirmPasswordStackView,
                                                       signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 40
        
        //make bottomStackView for "already on board" and "sign up"
        let bottomStackView = UIStackView(arrangedSubviews: [alreadyOnboardLabel, loginButton])
        bottomStackView.axis = .horizontal
        bottomStackView.spacing = 10
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel)
        view.addSubview(stackView)
        view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            bottomStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            bottomStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}


//MARK:- SwiftUI
import SwiftUI
//for working with canvas
struct SignUpVCProvider: PreviewProvider {
    static var previews: some View {
        Group {
            ContainerView().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = SignUpViewController()
        
        func makeUIViewController(context: Context) -> SignUpViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
    
}



