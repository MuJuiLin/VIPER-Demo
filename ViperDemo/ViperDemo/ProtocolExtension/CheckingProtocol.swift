//
//  CheckingProtocol.swift
//  ViperDemo
//
//  Created by MuRay Lin on 2018/11/16.
//  Copyright © 2018年 None. All rights reserved.
//

import Foundation

protocol CheckingProtocol {
    func isValidEmail(_ email: String?) -> Bool
    func isValidPassword(_ password: String?) -> Bool
    func areTheSameString(_ password: String?, _ confirmPassword: String?) -> Bool
}

extension CheckingProtocol {
    func isValidEmail(_ email: String?) -> Bool {
        guard let anEmail = email else { return false }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: anEmail)
    }
    
    func isValidPassword(_ password: String?) -> Bool  {
        guard let aPassword = password else { return false }
        
        return aPassword.count > 8
    }
    
    func areTheSameString(_ password: String?, _ confirmPassword: String?) -> Bool {
        guard let password = password, let confirmPassword = confirmPassword else {
            return false
        }
        return password == confirmPassword
    }
}
