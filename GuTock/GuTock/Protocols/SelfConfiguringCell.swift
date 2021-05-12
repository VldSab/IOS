//
//  SelfConfiguringCell.swift
//  GuTock
//
//  Created by Владимир Гуль on 12.05.2021.
//

import UIKit

protocol SelfConfiguringCell {
    static var reuseId: String {get}
    func configure(with value: MChat)
}
