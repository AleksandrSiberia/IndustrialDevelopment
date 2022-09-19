//
//  Coordinator.swift
//  Novigation
//
//  Created by Александр Хмыров on 13.09.2022.
//

import UIKit

// обертка UITabBarController
class RootCoordinator: AppCoordinator {

    private weak var transitionHandler: UITabBarController?
    var childs: [AppCoordinator] = []
    init(transitionHandler : UITabBarController) {
        self.transitionHandler = transitionHandler
    }


// старт логики открытия UITabBarController
    func start() -> UITabBarController? {
        if transitionHandler != nil {
        return showTabBarScreen()!
        }
        return nil
    }


    fileprivate func showTabBarScreen() -> UITabBarController? {

        let navFeedView = UINavigationController(rootViewController: FeedAssembly.createFeedViewController())
        let feedCoordinator = FeedCoordinator(transitionHandler: navFeedView)

        let navLoginView = UINavigationController(rootViewController: LoginAssembly.createLoginViewController())
        navLoginView.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.circle"), tag: 2)
        self.childs.append(feedCoordinator)

        // делаем дополнительные настройки
//        viewModel.input
//        viewModel.output = {
       // определяем то что происходит на выходе из модуля
//        }
        // передаем в transitionHandler

        transitionHandler!.tabBar.backgroundColor = .white
        transitionHandler!.viewControllers = [feedCoordinator.start(), navLoginView]
        return transitionHandler
    }


    func startProfileCoordinator() {

        let profileCoordinator = ProfileCoordinator(transitionHandler: self.transitionHandler!)
        self.childs.append(profileCoordinator)
        profileCoordinator.start()
    }
}


