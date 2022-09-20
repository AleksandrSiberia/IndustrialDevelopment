//
//  ProfileAssembly.swift
//  Novigation
//
//  Created by Александр Хмыров on 15.09.2022.
//

import Foundation



final class ProfileAssembly {

    static func createProfileViewController() -> ProfileViewController {

        let view = ProfileViewController()
     //   let arrayModelPost: [ModelPost] = [post1, post2, post3, post4]
        let viewModel = ProfileViewModel(director: view)

        view.delegate = viewModel
        return  view
    }
}
