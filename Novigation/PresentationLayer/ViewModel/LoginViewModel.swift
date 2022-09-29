//
//  LoginViewModel.swift
//  Novigation
//
//  Created by Александр Хмыров on 20.09.2022.
//

import Foundation


class LoginViewModel: LoginViewProtocol {

    var coordinator: RootCoordinator

    init(coordinator: RootCoordinator) {
        self.coordinator = coordinator

    }
}
