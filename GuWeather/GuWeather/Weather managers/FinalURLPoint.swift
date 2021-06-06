//
//  RequestManager.swift
//  GuWeather
//
//  Created by Владимир Гуль on 05.06.2021.
//

import Foundation

protocol FinalURLPoint {
    var fullURL: URL { get }
    var request: URLRequest { get }
}


