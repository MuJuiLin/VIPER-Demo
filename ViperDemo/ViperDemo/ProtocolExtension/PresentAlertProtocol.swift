//
//  PresentAlertProtocol.swift
//  ViperDemo
//
//  Created by MuRay Lin on 2018/11/16.
//  Copyright © 2018年 None. All rights reserved.
//

import Foundation
import UIKit

protocol PresentAlertProtocol {
    func presentAlert(_ alert: UIAlertController, from vc: UIViewController)
}

extension PresentAlertProtocol {
    func presentAlert(_ alert: UIAlertController, from vc: UIViewController) {
        vc.present(alert, animated: true, completion: nil)
    }
}
