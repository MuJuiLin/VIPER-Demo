//
//  LoginDataManager.swift
//  ViperDemo
//
//  Created by MuRay Lin on 2018/11/16.
//  Copyright © 2018年 None. All rights reserved.
//

import Foundation

typealias completion<T> = ( _ result: T?, _ errorMessage: String?) -> Void

class LoginDataManager {
    let ud = UserDefaults.standard
    let server = ServerManager(withProvider: APIProvider(withDomain: SERVER_URL))

    // MARK: - Server
    func fetchUserLoginInfo(withMemberSystemInfo info: MemberSystemInfo, completion: @escaping completion<LoginInfo>) {
        // Pretend we can check if the member information is correct
        guard loginCheck(withEmail: info.email, password: info.password) == true else {
            completion(nil, "Your email or password is incorrect")
            return
        }

        server.requestLogin(withEmail: info.email, password: info.password) { (result, error) in
            guard error == nil, let result = result else {
                completion(nil, error?.localizedDescription)
                return
            }
            if let dataDict = result["data"] as? [String: Any] {
                guard let data = try? JSONSerialization.data(withJSONObject: dataDict, options: []) else {
                    completion(nil, "Invalid JSON object")
                    return
                }
                if let loginInfo = try? JSONDecoder().decode(LoginInfo.self, from: data) {
                    completion(loginInfo, nil)
                }
                else {
                    completion(nil, "Invalid JSON object")
                }
            }
        }
    }

    // MARK: - UserDefault
    func getRegisteredEmail() -> String? {
        return ud.string(forKey: EMAIL_KEY)
    }

    func getRegisteredPassword() -> String? {
        return ud.string(forKey: PASSWORD_KEY)
    }

    func loginCheck(withEmail email: String?, password: String?) -> Bool {
        guard let email = email else { return false }
        guard let password = password else { return false }
        guard let registeredEmail = getRegisteredEmail() else { return false }
        guard let registeredPassword = getRegisteredPassword() else { return false }
        if registeredEmail != email { return false }
        if registeredPassword != password { return false }
        return true
    }
}
