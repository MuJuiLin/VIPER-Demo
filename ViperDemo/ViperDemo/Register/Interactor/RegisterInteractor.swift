//
//  RegisterInteractor.swift
//  ViperDemo
//
//  Created by MuRay Lin on 2018/11/16.
//  Copyright © 2018年 None. All rights reserved.
//

import Foundation

struct MemberSystemInfo {
    let email: String
    let password: String
}

class RegisterInteractor: CheckingProtocol {
    let dataManager = RegisterDataManager()

    func saveRegisterInfo(_ info: MemberSystemInfo) {
        dataManager.saveEmail(info.email)
        dataManager.savePassword(info.password)
    }
}
