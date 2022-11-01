//
//  UserRealmModel.swift
//  Novigation
//
//  Created by Александр Хмыров on 28.10.2022.
//

import Foundation
import RealmSwift
import UIKit



class RealmCategoryModel: Object {

    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var users: List<RealmUserModel>

}



class RealmUserModel: Object {

    @Persisted var login: String
    @Persisted var password: String

    var userFullName: String?
    var userStatus: String?
    var userImage: String?




}
