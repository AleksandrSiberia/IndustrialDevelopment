//
//  ArrayFoto.swift
//  Novigation
//
//  Created by Александр Хмыров on 06.09.2022.
//

import Foundation
import UIKit

//  "photo2"
public var arrayPhoto: [String] = ["photo1", "photo3", "photo4", "photo5", "photo6", "photo7", "photo8", "photo9", "photo10", "photo11", "photo12", "photo13", "photo14", "photo15", "photo16", "photo17", "photo18", "photo19", "photo20"]


public var arrayImages: [UIImage] =  {
    var array: [UIImage] = []
    for image in arrayPhoto { array.append(UIImage(named: image)!) }
    return array
}()

