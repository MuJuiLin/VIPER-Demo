//
//  RegisterPresenter.swift
//  ViperDemo
//
//  Created by MuRay Lin on 2018/11/16.
//  Copyright © 2018年 None. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol RegisterPresenterInputs {
    var email: BehaviorRelay<String?> { get }
    var password: BehaviorRelay<String?> { get }
    var confirmPassword: BehaviorRelay<String?> { get }
    func didTapRegister()
    func didTapToLogin()
}

protocol RegisterPresenterOutputs {
    var emailChecking: Driver<Bool> { get }
    var passwordChecking: Driver<Bool> { get }
}

class RegisterPresenter: RegisterPresenterInputs, RegisterPresenterOutputs {
    // MARK: - Inputs Params
    var email: BehaviorRelay<String?>
    var password: BehaviorRelay<String?>
    var confirmPassword: BehaviorRelay<String?>

    // MARK: - Outputs Params
    var emailChecking: Driver<Bool>
    var passwordChecking: Driver<Bool>

    // MARK: - RegisterPresenter
    var inputs: RegisterPresenterInputs { return self }
    var outputs: RegisterPresenterOutputs { return self }
    let interactor = RegisterInteractor()
    let router = RegisterRouter()
    unowned let view: RegisterViewController

    private let emailCheckingSubject: PublishSubject<Bool> = PublishSubject()
    private let passwordCheckingSubject: PublishSubject<Bool> = PublishSubject()

    init(withViewController vc: RegisterViewController) {
        view = vc
        email = BehaviorRelay(value: nil)
        password = BehaviorRelay(value: nil)
        confirmPassword = BehaviorRelay(value: nil)
        emailChecking = emailCheckingSubject.asDriver(onErrorJustReturn: false)
        passwordChecking = passwordCheckingSubject.asDriver(onErrorJustReturn: false)
    }

    func showSuccessAlert() {
        let alert = UIAlertController(title: nil, message: "Register Success", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        router.presentAlert(alert, from: view)
    }

    // MARK: - Inputs Function
    func didTapRegister() {
        let emailIsValid = interactor.isValidEmail(email.value)
        let passwordIsValid = interactor.areTheSameString(password.value, confirmPassword.value)
        emailCheckingSubject.onNext(emailIsValid)
        passwordCheckingSubject.onNext(passwordIsValid)

        if emailIsValid && passwordIsValid {
            let registerInfo = MemberSystemInfo(email: email.value ?? "", password: password.value ?? "")
            interactor.saveRegisterInfo(registerInfo)
            showSuccessAlert()
        }
    }

    func didTapToLogin() {
        router.pushToLoginView(from: view)
    }
}
