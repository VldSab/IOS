//
//  AuthError.swift
//  GuTock
//
//  Created by Владимир Гуль on 24.05.2021.
//

import UIKit

enum AuthError {
    
    case notFilled
    case invalidEmail
    case passwordsNotMatched
    case unknownError
    case serverError
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Fill all sections", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Email is not valid", comment: "")
        case .passwordsNotMatched:
            return NSLocalizedString("Passwords are not similar", comment: "")
        case .unknownError:
            return NSLocalizedString("Unknown error", comment: "")
        case .serverError:
            return NSLocalizedString("Server error", comment: "")

        }
    }
}
