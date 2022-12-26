//
//  ProfileAssembly.swift
//  Novigation
//
//  Created by Александр Хмыров on 15.09.2022.
//

import Foundation


final class ProfileAssembly {

    static func createProfileViewController() -> ProfileViewControllable {

        let view = ProfileViewController()
     
        let viewModel = ProfileViewModel(director: view)

        view.delegate = viewModel
        return  view
    }
}
