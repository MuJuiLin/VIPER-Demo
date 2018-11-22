//
//  UserInfoViewController.swift
//  ViperDemo
//
//  Created by MuRay Lin on 2018/11/20.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {

    @IBOutlet weak var llUsername: UILabel!
    @IBOutlet weak var llDate: UILabel!
    @IBOutlet weak var llToken: UILabel!
    
    var loginInfo: LoginInfo!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard loginInfo != nil else { fatalError("Please Init") }
        llUsername.text = loginInfo.username
        llDate.text = loginInfo.date
        llToken.text = loginInfo.token
    }

    func inject(withLoginInfo info: LoginInfo) {
        loginInfo = info
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
