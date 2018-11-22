//
//  LoginInfo.swift
//  ViperDemo
//
//  Created by MuRay Lin on 2018/11/20.
//  Copyright © 2018年 None. All rights reserved.
//

import Foundation
struct LoginInfo : Codable {
    let username : String?
    let date : String?
    let token : String?

    enum CodingKeys: String, CodingKey {
        case username = "username"
        case date = "date"
        case token = "token"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }
}
