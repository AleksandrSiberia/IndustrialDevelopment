//
//  Coordinator.swift
//  Novigation
//
//  Created by Александр Хмыров on 13.09.2022.
//

import UIKit

// обертка UITabBarController
class RootCoordinator: AppCoordinatorProtocol {
 


    private weak var transitionHandler: UITabBarController?

    var childs: [AppCoordinatorProtocol] = []

    var coreDataCoordinator = CoreDataCoordinator()


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
        navLoginView.tabBarItem = UITabBarItem(title: NSLocalizedString("navLoginView", tableName: "TabBarItemLocalizable", comment: "Profile") , image: UIImage(systemName: "person.circle"), tag: 2)
                self.childs.append(feedCoordinator)


        let savedPostsViewController = SavedPostsViewController()
        savedPostsViewController.coreDataCoordinator = self.coreDataCoordinator
        
        let navSavedPosts = UINavigationController(rootViewController: savedPostsViewController)
        self.navSavedPosts = navSavedPosts
        navSavedPosts.tabBarItem = UITabBarItem(title: NSLocalizedString("navSavedPosts", tableName: "TabBarItemLocalizable", comment: "Saved"), image: UIImage(systemName: "square.and.arrow.down"), tag: 3)



        self.navLoginView = navLoginView

        // делаем дополнительные настройки
//        viewModel.input
//        viewModel.output = {
       // определяем то что происходит на выходе из модуля
//        }
        // передаем в transitionHandler

        transitionHandler!.tabBar.backgroundColor = UIColor.createColorForTheme(lightTheme: .white, darkTheme: .black)
        
        transitionHandler!.viewControllers = [feedCoordinator.start(), navLoginView, navSavedPosts]
        return transitionHandler
    }


    func startProfileCoordinator(user: User) {
        
        let profileCoordinator = ProfileCoordinator(transitionHandler: self.navLoginView!, coreDataCoordinator: self.coreDataCoordinator, profileViewController: ProfileAssembly.createProfileViewController() as! ProfileViewController)
        self.childs.append(profileCoordinator)

        profileCoordinator.coreDataCoordinator = self.coreDataCoordinator

        profileCoordinator.start(user: user)
    }
}


