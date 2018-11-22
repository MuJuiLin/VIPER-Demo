//
//  LoginInteractor.swift
//  ViperDemo
//
//  Created by MuRay Lin on 2018/11/16.
//  Copyright © 2018年 None. All rights reserved.
//

import Foundation

class LoginInteractor {
    private let dataManager = LoginDataManager()

    func login(withMemberSystemInfo info: MemberSystemInfo, completion: @escaping completion<LoginInfo>) {
        dataManager.fetchUserLoginInfo(withMemberSystemInfo: info, completion: completion)
    }
}
