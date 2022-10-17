//
//  LoginViewControllerDelegate.swift
//  Novigation
//
//  Created by Александр Хмыров on 05.09.2022.
//

import Foundation
import FirebaseAuth

protocol LoginViewControllerDelegate {

    func checkCredentials(withEmail: String, password: String)
    func signUp(withEmail: String, password: String, completion: @escaping (String?) -> Void) 



    func check(_ loginViewController: LoginViewController, login: String, password: String) -> Bool
}



