//
//  ErrorManager.swift
//  GuNews
//
//  Created by Владимир Гуль on 11.06.2021.
//

import Foundation

enum ErrorManager: Error {
    case ResponseError
    case NoDataRecived
    case JSONParseError
    case JSONConversionFailed
    
    public var errorDescription: String {
        switch self {
        case .ResponseError:
            return NSLocalizedString("Missing HTTP response error", comment: "")
        case .JSONParseError:
            return NSLocalizedString("Cannot parse JSON", comment: "")
        case .NoDataRecived:
            return NSLocalizedString("No data recived", comment: "")
        case .JSONConversionFailed:
            return NSLocalizedString("JSON Convertion failed", comment: "")
        }
    }
}
