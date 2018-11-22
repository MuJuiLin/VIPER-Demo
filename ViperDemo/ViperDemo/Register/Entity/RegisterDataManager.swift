//
//  RegisterDataManager.swift
//  ViperDemo
//
//  Created by MuRay Lin on 2018/11/16.
//  Copyright © 2018年 None. All rights reserved.
//

import Foundation

let EMAIL_KEY = "viper_demo_email"
let PASSWORD_KEY = "viper_demo_password"

class RegisterDataManager {
    let ud = UserDefaults.standard

    func saveEmail(_ email: String) {
        ud.set(email, forKey: EMAIL_KEY)
    }

    func savePassword(_ password: String) {
        ud.set(password, forKey: PASSWORD_KEY)
    }
}
