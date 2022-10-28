//
//  UserRealmModel.swift
//  Novigation
//
//  Created by Александр Хмыров on 28.10.2022.
//

import Foundation
import RealmSwift
import UIKit

class UserRealmModel: Object {

    let login: String = ""
    let password: String = ""

    var userFullName: String = ""
    var userStatus: String = ""
    var userImage: String = ""
}
