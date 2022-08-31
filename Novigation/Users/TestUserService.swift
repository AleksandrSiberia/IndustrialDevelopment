//
//  TestUserService.swift
//  Novigation
//
//  Created by Александр Хмыров on 29.08.2022.
//

import UIKit

class TestUserService: UserService {

    private var currentUser: User = User("Test AleksandrSiberia",
                                         
                                         userStatus: "Test",
                                         userImage: UIImage(named: "avatar")! )

    func checkTheLogin(_ login: String, password: String, loginInspector: LoginViewControllerDelegate) -> User? {

        let check = loginInspector.check(login, password: password)

        guard check == true else {
            return nil
        }
        return currentUser
    }

}



