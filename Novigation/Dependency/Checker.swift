//
//  Checker.swift
//  Novigation
//
//  Created by Александр Хмыров on 31.08.2022.
//

import Foundation

final class Checker: LoginViewControllerDelegate {

    private let login: String = "1"
    private let password: String = "1"
    private init () {}

    static let shared = Checker()
    
    func check(_ loginViewController: LoginViewController, login: String, password: String) -> Bool {
        return self.login == login && self.password == password
    }
}





