//
//  Checker.swift
//  Novigation
//
//  Created by Александр Хмыров on 31.08.2022.
//

import Foundation
import FirebaseAuth



final class CheckService: LoginViewControllerDelegate {

    static let shared = CheckService()
}


extension CheckService: CheckServiceProtocol {

    func checkCredentials(withEmail: String, password: String, completion: @escaping (String?) -> Void ) {


        Auth.auth().signIn(withEmail: withEmail, password: password) {
            [weak self] authDataResult, error in

            guard self != nil else { return }


            if let error {
                completion(error.localizedDescription)
            }

            if authDataResult != nil {
                completion("Открыть доступ")
            }
                }
    }



    func signUp(withEmail: String, password: String, completion: @escaping (String?) -> Void )  {

        // FirebaseAuth.Auth.auth().currentUser

        Auth.auth().createUser(withEmail: withEmail, password: password){

            authDataResult, error in

            if let error {
                completion(error.localizedDescription)
            }

            if authDataResult != nil {

                completion("Пользователь зарегистрирован")
            }
        }

    }
}





