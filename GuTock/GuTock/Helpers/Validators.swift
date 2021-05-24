//
//  Validators.swift
//  GuTock
//
//  Created by Владимир Гуль on 24.05.2021.
//

import UIKit

class Validators {
    
    //if we can unwrapp and fills are not empty
    static func isFilled(email: String?, password: String?, repeatPassword: String?) -> Bool {
        guard let email = email, let password = password, let repeatPassword = repeatPassword,
            !email.isEmpty, !password.isEmpty, !repeatPassword.isEmpty else {
            return false
        }
        return true
    }
    
    static func isSimpleEmail(_ email: String) -> Bool {
        let emailRegEx = "^.+@.+\\..{2,}$"
        return check(text: email, regEx: emailRegEx)
    }
    
    private static func check(text: String, regEx: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
    
}
