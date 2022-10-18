//
//  LoginInspector.swift
//  Novigation
//
//  Created by Александр Хмыров on 05.09.2022.
//

import Foundation


struct LoginInspector: LoginViewControllerDelegate {


    func checkCredentials(withEmail: String, password: String, completion: @escaping (String?) -> Void) {

        CheckerService.shared.checkCredentials(withEmail: withEmail, password: password) { string in
            completion(string)
        }
    }

    func signUp(withEmail: String, password: String, completion: @escaping (String?) -> Void) {

        CheckerService.shared.signUp(withEmail: withEmail, password: password) { string in
            completion(string)
        }

    }

}
