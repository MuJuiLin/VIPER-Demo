//
//  CTMockApiProvider.swift
//  CookpadTest
//
//  Created by MuRay Lin on 2018/9/12.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class MockAPIProvider: APIProviderProtocol {
    func postLogin(withEmail email: String, password: String, callback: @escaping providerCompleteClosure) {
        let responseDict: [String: Any] =
        [
            "result": true,
            "data": [
                "username": "Mock API Demo",
                "date": "2018-11-20",
                "token": "fj1pa048jsmpv93nsfwe93"
            ],
            "msg": "login success"
        ]
        return callback(responseDict, nil, nil)
    }
}
