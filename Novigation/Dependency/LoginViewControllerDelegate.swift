//
//  LoginViewControllerDelegate.swift
//  Novigation
//
//  Created by Александр Хмыров on 05.09.2022.
//

import Foundation

protocol LoginViewControllerDelegate {
    func check(_ loginViewController: LoginViewController, login: String, password: String) -> Bool
}


