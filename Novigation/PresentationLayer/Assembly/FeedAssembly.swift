//
//  ScreenAssembly.swift
//  Novigation
//
//  Created by Александр Хмыров on 14.09.2022.
//

import Foundation


final class FeedAssembly {

    static func createFeedViewController() -> FeedViewController {
        
        let view = FeedViewController()
        let feedModel = FeedModel()
        let viewModel = FeedViewModel(director: view, feedModel: feedModel)


        view.delegate = viewModel
        return  view
    }
}
