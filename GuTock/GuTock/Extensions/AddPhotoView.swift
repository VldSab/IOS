//
//  AddPhotoView.swift
//  GuTock
//
//  Created by Владимир Гуль on 03.05.2021.
//

import UIKit

class AddPhotoView: UIView {
    
    var circleImageView: UIImageView = {
       let imageViewCircle = UIImageView()
        imageViewCircle.translatesAutoresizingMaskIntoConstraints = false
        imageViewCircle.image = #imageLiteral(resourceName: "avatar-4")
        imageViewCircle.contentMode = .scaleAspectFill
        imageViewCircle.layer.borderColor = UIColor.black.cgColor
        imageViewCircle.layer.borderWidth = 1
        return imageViewCircle
    }()
    
    
    let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let myImage = #imageLiteral(resourceName: "plus")
        button.setImage(myImage, for: .normal)
        button.tintColor = .buttonDark()
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(circleImageView)
        addSubview(plusButton)
        setupConstraints()        
    }
    
    private func setupConstraints() {
        
        //constraints for circleImage
        NSLayoutConstraint.activate([
            circleImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            circleImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            circleImageView.heightAnchor.constraint(equalToConstant: 100),
            circleImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        //constraints for plusButton
        NSLayoutConstraint.activate([
            plusButton.leadingAnchor.constraint(equalTo: circleImageView.trailingAnchor, constant: 16),
            plusButton.centerYAnchor.constraint(equalTo: circleImageView.centerYAnchor),
            plusButton.heightAnchor.constraint(equalToConstant: 30),
            plusButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        //fix bottom and trailing edge of AddPhotoView
        self.bottomAnchor.constraint(equalTo: circleImageView.bottomAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: plusButton.trailingAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circleImageView.layer.masksToBounds = true
        circleImageView.layer.cornerRadius = circleImageView.frame.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
