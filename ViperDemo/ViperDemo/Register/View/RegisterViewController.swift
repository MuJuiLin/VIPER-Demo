//
//  ViewController.swift
//  ViperDemo
//
//  Created by MuRay Lin on 2018/11/16.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RegisterViewController: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBOutlet weak var llEmailError: UILabel!
    @IBOutlet weak var llPasswordError: UILabel!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnToLogin: UIButton!

    lazy var presenter = RegisterPresenter(withViewController: self)
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        llEmailError.isHidden = true
        llPasswordError.isHidden = true
        self.title = "Register"
        bindPresenter()
    }

    func bindPresenter() {
        tfEmail.rx.text.bind(to: presenter.inputs.email).disposed(by: disposeBag)
        tfPassword.rx.text.bind(to: presenter.inputs.password).disposed(by: disposeBag)
        tfConfirmPassword.rx.text.bind(to: presenter.inputs.confirmPassword).disposed(by: disposeBag)
        btnRegister.rx.tap.bind(onNext: presenter.inputs.didTapRegister).disposed(by: disposeBag)
        btnToLogin.rx.tap.bind(onNext: presenter.inputs.didTapToLogin).disposed(by: disposeBag)

        presenter.outputs.emailChecking.asDriver(onErrorJustReturn: false).drive(onNext: { [weak self] (isValid) in
            self?.llEmailError.isHidden = isValid
        }).disposed(by: disposeBag)

        presenter.outputs.passwordChecking.asDriver(onErrorJustReturn: false).drive(onNext: { [weak self] (isValid) in
            self?.llPasswordError.isHidden = isValid
        }).disposed(by: disposeBag)
    }

    deinit {
        print("RegisterViewController deinit")
    }
}
