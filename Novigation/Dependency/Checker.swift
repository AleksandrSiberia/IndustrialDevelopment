//
//  Checker.swift
//  Novigation
//
//  Created by Александр Хмыров on 31.08.2022.
//

import Foundation

final class Checker: LoginViewControllerDelegate {

    private let login: String = "1"
    static let password: String = "03IYVB"
    private init () {}

    static let shared = Checker()
    
    func check(_ loginViewController: LoginViewController, login: String, password: String) -> Bool {
        return self.login == login && Checker.password == password
    }
}





