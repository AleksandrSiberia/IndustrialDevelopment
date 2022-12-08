//
//  TestUserService.swift
//  Novigation
//
//  Created by Александр Хмыров on 29.08.2022.
//

import UIKit

class TestUserService: UserServiceProtocol {


    func checkTheLogin(_ login: String, password: String, loginInspector: LoginViewControllerDelegate, loginViewController: LoginViewController, completion: @escaping (User?) -> Void ) {


        let currentUser: User = User("Test AleksandrSiberia",
                                                 userStatus: "Test",
                                                 userImage: UIImage(named: "avatar")! )


        // Сделать вход без пароля на тестовый user
        loginInspector.checkCredentials(withEmail: login, password: password) {string in

            guard string == "Открыть доступ" else {
                completion(nil)
                return
            }
            completion(currentUser)
        }
    }

}

