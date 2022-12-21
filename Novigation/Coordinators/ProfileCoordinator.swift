//
//  LoginCoordinator.swift
//  Novigation
//
//  Created by Александр Хмыров on 14.09.2022.
//

import UIKit

class ProfileCoordinator: AppCoordinatorProtocol {
    
    var coreDataCoordinator: CoreDataCoordinatorProtocol!

    private weak var transitionHandler: UINavigationController?
    var childs: [AppCoordinatorProtocol] = []

    var profileViewController: ProfileViewControllable!

    init(transitionHandler: UINavigationController, coreDataCoordinator: CoreDataCoordinatorProtocol, profileViewController: ProfileViewControllable!) {
        self.transitionHandler = transitionHandler
        self.coreDataCoordinator = coreDataCoordinator
        self.profileViewController = profileViewController
    }


    func start(user: User) -> Bool {

      

//        let profileViewController = ProfileAssembly.createProfileViewController()

        self.profileViewController.currentUser = user
        self.profileViewController.coreDataCoordinator = self.coreDataCoordinator


        self.transitionHandler?.pushViewController(profileViewController as! UIViewController, animated: true)

        return true

    }
}
