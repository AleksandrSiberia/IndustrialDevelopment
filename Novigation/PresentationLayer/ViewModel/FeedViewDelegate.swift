//
//  FeedViewModelProtocol.swift
//  Novigation
//
//  Created by Александр Хмыров on 19.09.2022.
//

import Foundation
import CoreGraphics


protocol FeedViewDelegate {

    var didChange: ((FeedViewDelegate) -> Void)? { get set }
    var colorWordVerification: CGColor { get set }
    var wordVerification: String? { get set }

    func takeTheWord(this word: String,
                           completion: @escaping (Result< String, CustomErrorNovigation >) -> Void)


}
