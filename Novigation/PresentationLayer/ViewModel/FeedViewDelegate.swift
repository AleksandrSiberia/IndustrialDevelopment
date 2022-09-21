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

}
