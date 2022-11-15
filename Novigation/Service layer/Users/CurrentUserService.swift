//
//  CurrentUserService.swift
//  Novigation
//
//  Created by Александр Хмыров on 29.08.2022.
//

import UIKit
import RealmSwift

class CurrentUserService: UserServiceProtocol {

   

    
    func checkTheLogin(_ login: String, password: String, loginInspector: LoginViewControllerDelegate, loginViewController: LoginViewController, completion: @escaping (User?) -> Void ) {

        // подгрузить юзера из базы данных в зависимости от логина и передать его в замыкание
        let currentUser: User = User("AleksandrSiberia",
                                                userStatus: "Работаю",
                                                userImage: UIImage(named: "avatar")! )

        loginInspector.checkCredentials(withEmail: login, password: password) {string in
            
            guard string == "Открыть доступ" else {
                completion(nil)
                return
            }
            completion(currentUser)
        }
    }
}
