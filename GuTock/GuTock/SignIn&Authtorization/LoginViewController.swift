//
//  LoginViewController.swift
//  GuTock
//
//  Created by Владимир Гуль on 02.05.2021.
//

import UIKit

class LoginViewController: UIViewController {

    let welcomeLabel = UILabel(text: "Welcome back!", font: .avenir26())
    
    //labeles
    let loginWithLabel = UILabel(text: "Login with")
    let orLabel = UILabel(text: "or")
    let emailLabel = UILabel(text: "Email")
    let passwordLabel = UILabel(text: "Password")
    let needAnAccountLabel = UILabel(text: "Need an account?")
    
    //buttons
    let googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white, isShadow: true)
    let loginButton = UIButton(title: "Login", titleColor: .white, backgroundColor: .buttonDark(), isShadow: true)
    let signUpButton: UIButton = {
        let signButton = UIButton(type: .system)
        signButton.setTitle("Sign Up", for: .normal)
        signButton.setTitleColor(.buttonRed(), for: .normal)
        signButton.titleLabel?.font = .avenir20()
        return signButton
    }()
    
    //text fields
    let emailTextField = OneLineTextField(font: .avenir20())
    let passwordTextField = OneLineTextField(font: .avenir20())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        SetupConstraints()
        
        //events click button
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped() {
        print(#function)
        AuthService.shared.login(email: emailTextField.text, password: passwordTextField.text) { result in
            switch result{
            
            case .success(let user):
                self.showAlert(with: "Welcome back", and: "")
            case .failure(let error):
                self.showAlert(with: "Error", and: error.localizedDescription)
            }
        }
    }
    
}

//MARK:- Constraints
extension LoginViewController {
    private func SetupConstraints() {
        
        //making compositions
        googleButton.customizeGoogleButton()
        let loginWithStack = ButtonFormView(label: loginWithLabel, button: googleButton)
       
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField])
        emailStackView.axis = .vertical
        emailStackView.spacing = 0
        
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField])
        passwordStackView.axis = .vertical
        passwordStackView.spacing = 0
        
        let bottomStackView = UIStackView(arrangedSubviews: [needAnAccountLabel, signUpButton])
        bottomStackView.axis = .horizontal
        bottomStackView.spacing = 10
        
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        //general stack
        let stackView = UIStackView(arrangedSubviews: [loginWithStack,
                                                       orLabel,
                                                       emailStackView,
                                                       passwordStackView,
                                                       loginButton])
        stackView.axis = .vertical
        stackView.spacing = 40
        
        //turn off autoresizing
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        //add elements on screen
        view.addSubview(welcomeLabel)
        view.addSubview(stackView)
        view.addSubview(bottomStackView)
        
        //ancors and activation
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 80),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            bottomStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            bottomStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
}

//MARK:- SwiftUI
import SwiftUI
//for working with canvas
struct LoginVCProvider: PreviewProvider {
    static var previews: some View {
        Group {
            ContainerView().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = LoginViewController()
        
        func makeUIViewController(context: Context) -> LoginViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
    
}
