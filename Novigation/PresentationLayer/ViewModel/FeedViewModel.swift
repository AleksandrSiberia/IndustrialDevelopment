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

    private func verification() {
        if self.wordVerification != "" {
            if self.secretWord == wordVerification { self.colorWordVerification = CGColor(red: 0, green: 1.0, blue: 0, alpha: 0.4) }
            else { self.colorWordVerification = CGColor(red: 1.0, green: 0, blue: 0, alpha: 0.5) }
        }
        else {
            print("Напишите слово")
        }
    }

    

}
