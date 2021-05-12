//
//  ActiveChatCell.swift
//  GuTock
//
//  Created by Владимир Гуль on 12.05.2021.
//

import UIKit

class ActiveChatCell: UICollectionViewCell, SelfConfiguringCell {
    static var reuseId: String = "ActiveChatCell"
    
    let friendImageView = UIImageView()
    let friendName = UILabel(text: "User", font: .laoSangamMN20())
    let lastMessage = UILabel(text: "Last message", font: .laoSangamMN18())
    let gradientView = GradientView(from: .topTrailing, to: .bottomLeading, startColor: #colorLiteral(red: 0.7882352941, green: 0.631372549, blue: 0.9411764706, alpha: 1), endColor: #colorLiteral(red: 0.4784313725, green: 0.6980392157, blue: 0.9215686275, alpha: 1))
    
    func configure(with value: MChat) {
        friendImageView.image = UIImage(named: value.userImage)
        friendName.text = value.username
        lastMessage.text = value.lastMessage
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        backgroundColor = .white
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK:- Setup Constraints
extension ActiveChatCell {
    private func setupConstraints() {
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        friendName.translatesAutoresizingMaskIntoConstraints = false
        lastMessage.translatesAutoresizingMaskIntoConstraints = false
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        friendImageView.backgroundColor = .red
        gradientView.backgroundColor = .black
        
        addSubview(friendImageView)
        addSubview(friendName)
        addSubview(lastMessage)
        addSubview(gradientView)
        
        NSLayoutConstraint.activate([
            friendImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            friendImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            friendImageView.heightAnchor.constraint(equalToConstant: 78),
            friendImageView.widthAnchor.constraint(equalToConstant: 78)
        ])
        
        NSLayoutConstraint.activate([
            gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            gradientView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: 78),
            gradientView.widthAnchor.constraint(equalToConstant: 8)
        ])
        
        NSLayoutConstraint.activate([
            friendName.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            friendName.leadingAnchor.constraint(equalTo: friendImageView.trailingAnchor, constant: 16),
            friendName.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            lastMessage.leadingAnchor.constraint(equalTo: friendImageView.trailingAnchor, constant: 16),
            lastMessage.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: -16),
            lastMessage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14)
        ])
        
    }
}
