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
   
    weak var delegate: WaitingChatsNavigation?
    
    private var chat : MChat
    init(chat: MChat) {
        self.chat = chat
        nameLabel.text = chat.friendUsername
        imageView.sd_setImage(with: URL(string: chat.friendAvatarstringURL), completed: nil)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        if let text = nameLabel.text {
            descriptionLabel.text = "\(text) wants to chat with you!"
        }
        buttonDeny.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        buttonAccept.addTarget(self, action: #selector(acceptButtonTapped), for: .touchUpInside)
        self.hideKeyboardWhenTappedAround()
    }
    
    @objc private func addButtonTapped() {
        self.dismiss(animated: true) {
            self.delegate?.removeWaitingChat(chat: self.chat)
        }
    }
    
    @objc private func acceptButtonTapped() {
        self.dismiss(animated: true) {
            self.delegate?.changeToActive(chat: self.chat)
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


