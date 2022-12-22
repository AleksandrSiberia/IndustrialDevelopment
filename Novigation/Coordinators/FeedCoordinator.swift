//
//  FeedCoordinator.swift
//  Novigation
//
//  Created by Александр Хмыров on 14.09.2022.
//

import UIKit

class FeedCoordinator: AppCoordinatorProtocol {



    private weak var transitionHandler: UINavigationController?

    var childs: [AppCoordinatorProtocol] = []

    init(transitionHandler: UINavigationController) {
        self.transitionHandler = transitionHandler
    }


    func start() -> UINavigationController {
        return showFeedScreen()
    }

    
    fileprivate func showFeedScreen() -> UINavigationController {
        
        let feedScreen = self.transitionHandler
        
        feedScreen?.tabBarItem = UITabBarItem(title: NSLocalizedString("feedScreen", tableName: "TabBarItemLocalizable", comment: "Лента") , image: UIImage(systemName: "house"), tag: 1)
        
        return feedScreen ?? UINavigationController()
    }
}



