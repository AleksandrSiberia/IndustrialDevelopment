//
//  UserService.swift
//  Novigation
//
//  Created by Александр Хмыров on 05.09.2022.
//

import Foundation

protocol UserServiceProtocol {
    func checkTheLogin(_ login: String, password: String, loginInspector: LoginViewControllerDelegate, loginViewController: LoginViewController, completion: @escaping (User?) -> Void )
}
