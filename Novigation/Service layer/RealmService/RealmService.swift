//
//  RealmService.swift
//  Novigation
//
//  Created by Александр Хмыров on 28.10.2022.
//

import Foundation
import RealmSwift

final class RealmService {


    let realm = try! Realm()

    static let shared = RealmService()


    private init(){
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

        let arrayCategory = realm.objects(RealmCategoryModel.self)

        return Array(arrayCategory)

    }




    func getAllUsers() -> [RealmUserModel]? {

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

            print("user >>>>>", user)
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
