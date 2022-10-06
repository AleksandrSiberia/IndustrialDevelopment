//
//  LoginInspector.swift
//  Novigation
//
//  Created by Александр Хмыров on 05.09.2022.
//

import Foundation

struct LoginInspector: LoginViewControllerDelegate {

    func check(_ loginViewController: LoginViewController, login: String, password: String) -> Bool {
        return Checker.shared.check(loginViewController, login: login, password: password)
    }
}
