//
//  FinalURLPoint.swift
//  PhotoCollection
//
//  Created by Владимир Гуль on 09.06.2021.
//

import Foundation

protocol FinalURLPoint {
    var fullURL: URL { get }
    var request: URLRequest { get }
}
