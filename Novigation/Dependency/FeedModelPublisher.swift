//
//  FeedModel.swift
//  Novigation
//
//  Created by Александр Хмыров on 08.09.2022.
//

//import UIKit
//
//
//
//class FeedModelPublisher {
//    private var subscribers: [FeedModelSubscribers] = []
//    private var word: String = "secretWord"
//
//    func add(subscriber: FeedModelSubscribers) {
//        self.subscribers.append(subscriber)
//    }
//
//    
//    func delete(subscriber filter: (FeedModelSubscribers) -> Bool ) {
//        guard let index = subscribers.firstIndex(where: filter) else { return }
//        self.subscribers.remove(at: index)
//    }
//
//
//    func check(_ word: String?) {
//    
//        if word != "" {
//            self.word == word ? subscribers.forEach( { $0.changeTheColor(.green) } ) : subscribers.forEach( { $0.changeTheColor(.red)  } )
//        }
//        else {  print("напишите слово") }
//    }
//}
