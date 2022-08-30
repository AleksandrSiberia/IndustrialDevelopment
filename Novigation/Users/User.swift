//
//  User.swift
//  Novigation
//
//  Created by Александр Хмыров on 29.08.2022.
//

import UIKit

class User {
    var userFullName: String
    var userLogin: String
    var userPassword: String
    var userStatus: String
    var userImage: UIImage

    init (_ userFullName: String, userLogin: String, userPassword: String, userStatus: String, userImage: UIImage) {
        self.userFullName = userFullName
        self.userLogin = userLogin
        self.userPassword = userPassword
        self.userStatus = userStatus
        self.userImage = userImage
    }
}



