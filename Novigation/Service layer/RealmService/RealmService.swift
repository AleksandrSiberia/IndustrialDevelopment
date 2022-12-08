//
//  RealmService.swift
//  Novigation
//
//  Created by Александр Хмыров on 28.10.2022.
//

import Foundation
import RealmSwift
import KeychainSwift




final class RealmService {



    lazy var config = Realm.Configuration(encryptionKey: KeychainSwift().getData("realmKey"))


    lazy var realm = try! Realm(configuration: config)

    static let shared = RealmService()



    private init(){

    }


    
    func setRealmKey() -> Data {

        var key = Data(count: 64)

        _ = key.withUnsafeMutableBytes { (pointer:
                                            UnsafeMutableRawBufferPointer) in
            SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!) }

        return key
    }



    func setCategory(name: String) {
        let newCategory = RealmCategoryModel()
        newCategory.name = name
        try! realm.write {
            realm.add(newCategory) }
    }





    func setUser(user: RealmUserModel) {

        let idAllCategory = realm.objects(RealmCategoryModel.self)[0].id

        guard let category = realm.object(ofType: RealmCategoryModel.self, forPrimaryKey: idAllCategory) else {
            print("категории с id \(idAllCategory) не существует")
            return
        }
        try! realm.write {
            category.users.append(user)
        }
    }





    func getAllCategory() -> [RealmCategoryModel] {


        let arrayRealmCategory = realm.objects(RealmCategoryModel.self)
        let arrayCategory = Array(arrayRealmCategory)
        return arrayCategory

    }




    func getAllUsers() -> [RealmUserModel]? {

        if self.getAllCategory().isEmpty {
                    self.setCategory(name: "AllUser")
                }

        guard self.getAllCategory().isEmpty == false else {
            print("нет категории")
            return nil
        }

        let idAllCategory = realm.objects(RealmCategoryModel.self)[0].id

        guard let categoryUsers = realm.object(ofType: RealmCategoryModel.self, forPrimaryKey: idAllCategory)?.users else {
            print("категории с id \(idAllCategory) не существует")
            return nil
        }

            return Array(categoryUsers)

    }





    func deleteUser(indexInArrayUsers: Int) {


        if self.getAllUsers()!.count > indexInArrayUsers {

            let user = self.getAllUsers()?[indexInArrayUsers]

            try! realm.write {
                realm.delete(user!)
            }
        }
        else {
            print("error: index out array")
        }

    }




    func deleteCategory(category: RealmCategoryModel) {

        for user in category.users {
            try! realm.write {
                realm.delete( user )
            }
        }

        try! realm.write {
            realm.delete(category)
        }
    }

}
