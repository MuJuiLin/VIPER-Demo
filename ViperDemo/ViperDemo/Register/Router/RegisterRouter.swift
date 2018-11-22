//
//  RegisterRouter.swift
//  ViperDemo
//
//  Created by MuRay Lin on 2018/11/16.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class RegisterRouter: PresentAlertProtocol {
    var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func pushToLoginView(from vc: RegisterViewController) {
        let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
        vc.navigationController?.pushViewController(loginVC, animated: true)
    }
}
