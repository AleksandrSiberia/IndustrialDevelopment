//
//  LoginAssembly.swift
//  Novigation
//
//  Created by Александр Хмыров on 14.09.2022.
//

import Foundation


final class LoginAssembly {

    static func createLoginViewController() -> LoginViewController {

        let view = LoginViewController()

        let loginInspector = MyLoginFactory().makeLoginInspector()
        view.loginDelegate = loginInspector

        return  view
    }
}
