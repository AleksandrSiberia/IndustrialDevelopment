//
//  LoginInspector.swift
//  Novigation
//
//  Created by Александр Хмыров on 05.09.2022.
//

import Foundation
import FirebaseAuth

struct LoginInspector: LoginViewControllerDelegate {




    func checkCredentials(withEmail: String, password: String) {
        CheckerService.shared.checkCredentials(withEmail: withEmail, password: password)
    }

    func signUp(withEmail: String, password: String, completion: @escaping (String?) -> Void) {

        CheckerService.shared.signUp(withEmail: withEmail, password: password) { string in
            completion(string)
        }




    }

    



    

    func check(_ loginViewController: LoginViewController, login: String, password: String) -> Bool {
        return CheckerService.shared.check(loginViewController, login: login, password: password)
    }
}
