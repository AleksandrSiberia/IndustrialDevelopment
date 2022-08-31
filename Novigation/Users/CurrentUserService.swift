//
//  CurrentUserService.swift
//  Novigation
//
//  Created by Александр Хмыров on 29.08.2022.
//

import UIKit

protocol UserService {
    func checkTheLogin(_ login: String, password: String, loginInspector: LoginViewControllerDelegate) -> User?
}


class CurrentUserService: UserService {

    private var currentUser: User = User("AleksandrSiberia",
                                         userStatus: "Работаю",
                                         userImage: UIImage(named: "avatar")! )
    
    func checkTheLogin(_ login: String, password: String, loginInspector: LoginViewControllerDelegate ) -> User? {

        let check = loginInspector.check(login, password: password)
        guard check == true else {
            return nil
        }
        return currentUser
    }
}

