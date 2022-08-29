//
//  CurrentUserService.swift
//  Novigation
//
//  Created by Александр Хмыров on 29.08.2022.
//

import UIKit

protocol UserService {
    func checkTheLogin(_ login: String, password: String, user: User) -> User?
}


class CurrentUserService: UserService {

    private var currentUser: User?
    
    func checkTheLogin(_ login: String, password: String, user: User) -> User? {
        self.currentUser = user
        guard login == currentUser!.userLogin && password == currentUser!.userPassword else {
            return nil
        }
        return currentUser
    }
}


