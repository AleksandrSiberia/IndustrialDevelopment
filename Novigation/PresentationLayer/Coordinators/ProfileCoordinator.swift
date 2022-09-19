//
//  LoginCoordinator.swift
//  Novigation
//
//  Created by Александр Хмыров on 14.09.2022.
//

import UIKit

class ProfileCoordinator: AppCoordinator {

    private weak var transitionHandler: UITabBarController?
    var childs: [AppCoordinator] = []
    init(transitionHandler: UITabBarController) {
        self.transitionHandler = transitionHandler
    }


    func start(){
        return showFeedScreen()
    }


    fileprivate func showFeedScreen() {
        self.transitionHandler?.navigationController?.pushViewController(ProfileAssembly.createProfileViewController(), animated: true)
    }
}
