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

    var navLoginView: UINavigationController?
    var navSavedPosts: UINavigationController?


    fileprivate func showTabBarScreen() -> UITabBarController? {

        let navFeedView = UINavigationController(rootViewController: FeedAssembly.createFeedViewController())
        let feedCoordinator = FeedCoordinator(transitionHandler: navFeedView)

        let navLoginView = UINavigationController(rootViewController: LoginAssembly.createLoginViewController(coordinator: self))
        navLoginView.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.circle"), tag: 2)
                self.childs.append(feedCoordinator)


        let profileSavedPostsViewController = ProfileViewController()
        profileSavedPostsViewController.savedPostsController = true
        let navSavedPosts = UINavigationController(rootViewController: profileSavedPostsViewController)
        self.navSavedPosts = navSavedPosts
        navSavedPosts.tabBarItem = UITabBarItem(title: "Сохраненные", image: UIImage(systemName: "square.and.arrow.down"), tag: 3)



        self.navLoginView = navLoginView

        // делаем дополнительные настройки
//        viewModel.input
//        viewModel.output = {
       // определяем то что происходит на выходе из модуля
//        }
        // передаем в transitionHandler

        transitionHandler!.tabBar.backgroundColor = .white
        transitionHandler!.viewControllers = [feedCoordinator.start(), navLoginView, navSavedPosts]
        return transitionHandler
    }


    func startProfileCoordinator(user: User) {
        

        let profileCoordinator = ProfileCoordinator(transitionHandler: self.navLoginView!)
        self.childs.append(profileCoordinator)
        profileCoordinator.start(user: user)
    }
}


