//
//  WaitingChatCell.swift
//  GuTock
//
//  Created by Владимир Гуль on 12.05.2021.
//

import UIKit

class WaitingChatCell: UICollectionViewCell, SelfConfiguringCell {
    
    
    
    static var reuseId: String = "WaitingChatCell"
    
    let friendImageView = UIImageView()
    
    func configure(with value: MChat) {
        friendImageView.image = UIImage(named: value.userImage)
    }
    
    func configure<U>(with value: U) where U : Hashable {
        guard let chat: MChat = value as? MChat else {
            fatalError("Value \(value) is not MChat type")
        }
        friendImageView.image = UIImage(named: chat.userImage)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .link
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension WaitingChatCell {
    private func setupConstraints() {
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(friendImageView)
        
        NSLayoutConstraint.activate([
            friendImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            friendImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            friendImageView.heightAnchor.constraint(equalToConstant: 88),
            friendImageView.widthAnchor.constraint(equalToConstant: 88)
        ])
    }
    
}
