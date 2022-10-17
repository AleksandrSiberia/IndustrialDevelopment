//
//  Checker.swift
//  Novigation
//
//  Created by Александр Хмыров on 31.08.2022.
//

import Foundation
import FirebaseAuth

final class CheckerService: LoginViewControllerDelegate {


    private let login: String = "1@mail.ru"
    static let password: String = "03IYVB"
    private init () {}

    static let shared = CheckerService()

}

extension CheckerService: CheckerServiceProtocol {
 

    func checkCredentials(withEmail: String, password: String, completion: @escaping (String?) -> Void ) {
        Auth.auth().signIn(withEmail: withEmail, password: password) {
            [weak self] authDataResult, error in

            guard self != nil else { return }

            if let error {
                print(withEmail, password, "error >>>>>", error)
                completion(error.localizedDescription)
            }
            
            if let authDataResult {
                print("authDataResult >>>>>", authDataResult)
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

            if let authDataResult {
                print(withEmail, password, "authDataResult >>>>>", authDataResult)
                completion("Пользователь зарегистрирован")
            }
        }

    }
}





