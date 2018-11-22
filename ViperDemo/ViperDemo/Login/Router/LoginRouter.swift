//
//  LoginRouter.swift
//  ViperDemo
//
//  Created by MuRay Lin on 2018/11/16.
//  Copyright © 2018年 None. All rights reserved.
//

import Foundation
import UIKit

class LoginRouter: PresentAlertProtocol {
    var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }

    func pushToUserInfoView(from vc:LoginViewController, withUserInfo info: LoginInfo) {
        if let userInfoVC = mainStoryboard.instantiateViewController(withIdentifier: "UserInfoViewController") as? UserInfoViewController {
            userInfoVC.inject(withLoginInfo: info)
            vc.navigationController?.pushViewController(userInfoVC, animated: true)
        }
        else {
            fatalError("No such view controller")
        }
    }
}
