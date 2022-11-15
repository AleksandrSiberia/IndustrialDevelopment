//
//  CustomViewOutput.swift
//  Novigation
//
//  Created by Александр Хмыров on 14.09.2022.
//

import Foundation


protocol FeedViewControllerDelegate {

    var onSelectAction: (() -> Void)? { get }
}
