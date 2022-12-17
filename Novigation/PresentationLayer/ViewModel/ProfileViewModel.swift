//
//  ProfileViewModel.swift
//  Novigation
//
//  Created by Александр Хмыров on 20.09.2022.
//

import Foundation


class ProfileViewModel: ProfileViewDelegate {

    var director: AnyObject


    var posts: [ModelPost]? {
        didSet {
            self.didChange?(self)
        }
    }


    var didChange: ((ProfileViewDelegate) -> Void)?

    init(director: AnyObject) {
        self.director = director
    }


    func showPost() {
        self.posts = arrayModelPost
    }
}
