//
//  LoginCoordinator.swift
//  Novigation
//
//  Created by Александр Хмыров on 14.09.2022.
//

import UIKit

class ProfileCoordinator: AppCoordinator {
    


    private weak var transitionHandler: UINavigationController?
    var childs: [AppCoordinator] = []
    init(transitionHandler: UINavigationController) {
        self.transitionHandler = transitionHandler
    }


    func start(user: User) {

        let profileViewController = ProfileAssembly.createProfileViewController()
        profileViewController.currentUser = user

        self.transitionHandler?.pushViewController(profileViewController, animated: true)
    }
}
