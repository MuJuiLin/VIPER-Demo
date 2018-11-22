//
//  ServerConnection.swift
//  CookpadTest
//
//  Created by MuRay Lin on 2018/9/11.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

let SERVER_URL = "http://demo3807192.mockable.io/"

typealias completeClosure = ( _ result: [String: Any]?, _ error: Error?) -> Void

class ServerManager: NSObject {
    
    var apiProvider: APIProviderProtocol
    
    init(withProvider provider: APIProviderProtocol) {
        apiProvider = provider
    }

    func requestLogin(withEmail email: String, password: String, callback: @escaping completeClosure) {
        apiProvider.postLogin(withEmail: email, password: password) { (dict, reponse, error) in
            DispatchQueue.main.async {
                callback(dict, error)
            }
        }
    }
}
