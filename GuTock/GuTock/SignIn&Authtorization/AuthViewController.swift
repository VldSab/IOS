//
//  ViewController.swift
//  GuTock
//
//  Created by Владимир Гуль on 25.04.2021.
//

import UIKit
import GoogleSignIn

class AuthViewController: UIViewController {
    
    //create buttons for the onbording screens
    let googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white, isShadow: true)
    let emailButton = UIButton(title: "Email", titleColor: .white, backgroundColor: .buttonDark(), isShadow: false)
    let loginButton = UIButton(title: "Login", titleColor: .buttonRed(), backgroundColor: .white, isShadow: true)
    
    //create labeles for the onbording screens
    let googleLabel = UILabel(text: "Get started with")
    let emailLabel = UILabel(text: "Or sign up with")
    let alreadyOnboardLabel = UILabel(text: "Already onboard?")
    
    //controllers
    let signUpVC = SignUpViewController()
    let loginVC = LoginViewController()
    
    //app logo
    let logoImageView = UIImageView(image: #imageLiteral(resourceName: "logo1.0"), contentMode: .scaleAspectFit)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        
        //events click button
        emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)

        signUpVC.delegate = self
        loginVC.delegate = self
        GIDSignIn.sharedInstance()?.delegate = self
        
    }
    
    @objc private func emailButtonTapped() {
        print(#function)
        present(signUpVC, animated: true, completion: nil)
    }
    
    @objc private func loginButtonTapped() {
        print(#function)
        present(loginVC, animated: true, completion: nil)
    }
    
    //autorization with google
    @objc private func googleButtonTapped() {
        print(#function)
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }
}

//MARK: - Setup Constraints
extension AuthViewController {
    
    private func setupConstraints(){
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        //initializing buttonforms (button+label)
        googleButton.customizeGoogleButton()
        let googleView = ButtonFormView(label: googleLabel, button: googleButton)
        let emailView = ButtonFormView(label: emailLabel, button: emailButton)
        let alreadyOnboardView = ButtonFormView(label: alreadyOnboardLabel, button: loginButton)
        
        //creating stackview with our ButtonForms
        let stackView = UIStackView(arrangedSubviews: [googleView, emailView, alreadyOnboardView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 40
        
        view.addSubview(logoImageView)
        view.addSubview(stackView)
        
        //making anchors
        logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 160),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}

//MARK:- Delegate
extension AuthViewController: AuthNavigatingDelegate {
    func toLoginVC() {
        present(loginVC, animated: true, completion: nil)
    }
    
    func toSignUpVC() {
        present(signUpVC, animated: true, completion: nil)
    }
    
    
}

extension AuthViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        AuthService.shared.googleLogin(user: user, error: error) { result in
            switch result {
            
            case .success(let user):
                FirestoreService.shared.getUserData(user: user) { result in
                    switch result {
                        
                    case .success(let mUser):
                        
                        let mainTabBarController = MainTabBarController(currentUser: mUser)
                        mainTabBarController.modalPresentationStyle = .fullScreen
                        UIApplication.getTopViewController()?.present(mainTabBarController, animated: true, completion: nil)
                    case .failure(_):
                        UIApplication.getTopViewController()?.present(SetupProfileViewController(currentUser: user), animated: true, completion: nil)
                    }
                }
            case .failure(let error):
                self.showAlert(with: "Error", and: error.localizedDescription)
            }
        }
    }
}

//MARK: - SwiftUI
import SwiftUI
//for working with canvas
struct AuthVCProvider: PreviewProvider {
    static var previews: some View {
        Group {
            ContainerView().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = AuthViewController()
        
        func makeUIViewController(context: Context) -> AuthViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
    
}
