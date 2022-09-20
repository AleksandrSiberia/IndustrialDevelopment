//
//  ProfileViewProtocol.swift
//  Novigation
//
//  Created by Александр Хмыров on 20.09.2022.
//

import Foundation

protocol ProfileViewDelegate {

    var posts: [ModelPost]? { get set }

    var didChange: ((ProfileViewDelegate) -> Void)? { get set }

    func showPost()

}

