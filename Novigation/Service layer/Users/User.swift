//
//  User.swift
//  Novigation
//
//  Created by Александр Хмыров on 29.08.2022.
//

import UIKit


//protocol Userable {
//
//    var userFullName: String { get set
//    }
//    var userStatus: String { get set }
//    var userImage: UIImage { get set }
//
//}

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



