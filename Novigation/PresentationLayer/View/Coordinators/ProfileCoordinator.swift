//
//  LoginCoordinator.swift
//  Novigation
//
//  Created by Александр Хмыров on 14.09.2022.
//

import UIKit

class ProfileCoordinator: AppCoordinatorProtocol {
    
    var coreDataCoordinator: CoreDataCoordinator!

    private weak var transitionHandler: UINavigationController?
    var childs: [AppCoordinatorProtocol] = []

    init(transitionHandler: UINavigationController, coreDataCoordinator: CoreDataCoordinator) {
        self.transitionHandler = transitionHandler
        self.coreDataCoordinator = coreDataCoordinator
    }


    func start(user: User) {

        let profileViewController = ProfileAssembly.createProfileViewController()
        profileViewController.currentUser = user
        profileViewController.coreDataCoordinator = self.coreDataCoordinator

        self.transitionHandler?.pushViewController(profileViewController, animated: true)
    }
}
