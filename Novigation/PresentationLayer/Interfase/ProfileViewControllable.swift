//
//  File.swift
//  Novigation
//
//  Created by Александр Хмыров on 21.12.2022.
//

import Foundation


protocol ProfileViewControllable {

    var currentUser: User? { get set }
    var coreDataCoordinator: CoreDataCoordinatorProtocol! { get set }
}
