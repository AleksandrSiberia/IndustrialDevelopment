//
//  FeedViewModel.swift
//  Novigation
//
//  Created by Александр Хмыров on 19.09.2022.
//

import Foundation
import CoreGraphics


final class FeedViewModel: FeedViewDelegate {


    var director: AnyObject

    private let secretWord: String
    
    var colorWordVerification: CGColor = CGColor(gray: 0, alpha: 0)
    
    var wordVerification: String? {
        didSet {

            verification()
            self.didChange?(self)
        }
    }

    var didChange: ((FeedViewDelegate) -> Void)?

    init(director: AnyObject, feedModel: FeedModel) {
        self.secretWord = FeedModel.secretWord
        self.director = director
    }


    func takeTheWord(this word: String,
                           completion: @escaping (Result<String, CustomErrorNovigation> ) -> Void) {
        guard word == self.secretWord else {
            completion(.failure(.noWord) )
            return
        }
        completion(.success(word) )
    }



    private func verification() {

        if self.wordVerification != "" {
            takeTheWord(this: self.wordVerification!) { result in
                switch result {
                case .success(let word):
                    self.colorWordVerification = CGColor(red: 0, green: 1.0, blue: 0, alpha: 0.4)
                    print("Слово \(word) подошло")
                case .failure(let error):
                    self.colorWordVerification = CGColor(red: 1.0, green: 0, blue: 0, alpha: 0.5)
                    print(error.rawValue)
                }
            }
        }
        else {
            print("Напишите слово")
        }
    }
}
