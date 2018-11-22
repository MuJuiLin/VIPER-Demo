//
//  LoginPresenter.swift
//  ViperDemo
//
//  Created by MuRay Lin on 2018/11/16.
//  Copyright © 2018年 None. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol LoginPresenterInputs {
    var email: BehaviorRelay<String?> { get }
    var password: BehaviorRelay<String?> { get }
    func didTapLogin()
}

protocol LoginPresenterOutputs {
    
}

class LoginPresenter: LoginPresenterInputs, LoginPresenterOutputs {
    // MARK: - Inputs Params
    var email: BehaviorRelay<String?>
    var password: BehaviorRelay<String?>
    
    // MARK: - Outputs Params
    
    // MARK: - LoginPresenter
    var inputs: LoginPresenterInputs { return self }
    var outputs: LoginPresenterOutputs { return self }
    private let interactor = LoginInteractor()
    private let router = LoginRouter()
    unowned let view: LoginViewController
    
    init(withViewController vc: LoginViewController) {
        view = vc
        email = BehaviorRelay(value: nil)
        password = BehaviorRelay(value: nil)
    }

    func showFailureAlert(withMessage message: String?) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        router.presentAlert(alert, from: view)
    }

    // MARK: - Inputs Function
    func didTapLogin() {
        let info = MemberSystemInfo.init(email: email.value ?? "", password: password.value ?? "")
        interactor.login(withMemberSystemInfo: info) { [weak self] (loginInfo, errorMessage) in
            guard let weakSelf = self else { return }
            if let loginInfo = loginInfo {
                weakSelf.router.pushToUserInfoView(from: weakSelf.view, withUserInfo: loginInfo)
            }
            else {
                weakSelf.showFailureAlert(withMessage: errorMessage)
            }
        }
    }
}
