//
//  User.swift
//  Novigation
//
//  Created by Александр Хмыров on 29.08.2022.
//

import UIKit

class User {
    var userFullName: String
    var userStatus: String
    var userImage: UIImage


    init (_ userFullName: String, userStatus: String, userImage: UIImage) {
        self.userFullName = userFullName
        self.userStatus = userStatus
        self.userImage = userImage
    }
}



