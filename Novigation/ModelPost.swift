//
//  ModelPost.swift
//  Novigation
//
//  Created by Александр Хмыров on 14.06.2022.
//

import UIKit

protocol ModelPost {
    var author: String { get set }
    var image: String  { get set }
    var description: String  { get set }
    var likes: Int  { get set }
    var views: Int  { get set }
}

