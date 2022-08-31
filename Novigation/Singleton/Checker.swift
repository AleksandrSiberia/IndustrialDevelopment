//
//  Checker.swift
//  Novigation
//
//  Created by Александр Хмыров on 31.08.2022.
//

import Foundation

protocol LoginViewControllerDelegate {
    func check(_ login: String, password: String) -> Bool
}

class Checker: LoginViewControllerDelegate {

    private let login: String = "1"
    private let password: String = "1"
    private init () {}
    public static var shared = Checker()
    
    func check(_ login: String, password: String) -> Bool {
        return self.login == login && self.password == password
    }
}

struct LoginInspector: LoginViewControllerDelegate {
    func check(_ login: String, password: String) -> Bool {
        return Checker.shared.check(login, password: password)
    }
}


