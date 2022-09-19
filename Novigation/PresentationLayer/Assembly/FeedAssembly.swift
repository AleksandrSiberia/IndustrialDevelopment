//
//  ScreenAssembly.swift
//  Novigation
//
//  Created by Александр Хмыров on 14.09.2022.
//

import Foundation


final class FeedAssembly {

    static func createFeedViewController() -> FeedViewController {

        //      добавить вью модель
        let view = FeedViewController()
        return  view
    }
}


//final class CardListAssembly {
//
//    func create(
//        output: CardListOutput,
//        serviceLocator: ServiceLocator
//    ) -> CardListViewController {
//
//        let view = CardListViewController()
//        let presenter = CardListPresenter(
//            output: output,
//            view: view
//        )
//
//        view.output = presenter
//
//        return view
//    }
//}
