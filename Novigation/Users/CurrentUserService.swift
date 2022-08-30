//
//  CurrentUserService.swift
//  Novigation
//
//  Created by Александр Хмыров on 29.08.2022.
//

import UIKit

protocol UserService {
    func checkTheLogin(_ login: String, password: String) -> User?
}


class CurrentUserService: UserService {

    private var currentUser: User = User("AleksandrSiberia", userLogin: "1", userPassword: "1", userStatus: "Работаю", userImage: UIImage(named: "avatar")! )
    
    func checkTheLogin(_ login: String, password: String) -> User? {
                guard login == currentUser.userLogin && password == currentUser.userPassword else {
            return nil
        }
        return currentUser
    }
}


