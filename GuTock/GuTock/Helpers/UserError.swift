//
//  UserError.swift
//  GuTock
//
//  Created by Владимир Гуль on 27.05.2021.
//

import Foundation

enum UserError {
    case notFilled
    case photoNotExist
    case cannotGetUserInfo
    case cannotUnwwrapToMUser
}

extension UserError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Fill all sections", comment: "")
        case .photoNotExist:
            return NSLocalizedString("Photo not exist", comment: "")
        case .cannotGetUserInfo:
            return NSLocalizedString("Can not get info about user", comment: "")
        case .cannotUnwwrapToMUser:
            return NSLocalizedString("Can not unwrap to MUser", comment: "")
        }
    }
}
