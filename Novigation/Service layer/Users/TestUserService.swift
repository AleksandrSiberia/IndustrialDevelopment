//
//  TestUserService.swift
//  Novigation
//
//  Created by Александр Хмыров on 29.08.2022.
//

import UIKit

class TestUserService: UserServiceProtocol {

    private var currentUser: User = User("Test AleksandrSiberia",
                                         
                                         userStatus: "Test",
                                         userImage: UIImage(named: "avatar")! )

    func checkTheLogin(_ login: String, password: String, loginInspector: LoginViewControllerDelegate, loginViewController: LoginViewController) -> User? {

        let check: () = loginInspector.checkCredentials(withEmail: login, password: password)
        print(check)

        return nil

        //        let check = loginInspector.check(loginViewController, login: login, password: password)

        //        guard check == true else {
        //            return nil
        //        }
        //        return currentUser
    }

    

}

