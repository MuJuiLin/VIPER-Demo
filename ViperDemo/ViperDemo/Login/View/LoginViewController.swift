//
//  LoginViewController.swift
//  ViperDemo
//
//  Created by MuRay Lin on 2018/11/16.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    lazy var presenter = LoginPresenter(withViewController: self)
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Login"
        bindPresenter()
    }

    func bindPresenter() {
        tfEmail.rx.text.bind(to: presenter.inputs.email).disposed(by: disposeBag)
        tfPassword.rx.text.bind(to: presenter.inputs.password).disposed(by: disposeBag)
        btnLogin.rx.tap.bind(onNext: presenter.inputs.didTapLogin).disposed(by: disposeBag)
    }
    
    deinit {
        print("LoginViewController deinit")
    }

}
