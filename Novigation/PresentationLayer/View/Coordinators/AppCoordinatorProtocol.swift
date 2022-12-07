//
//  AppCoordinator.swift
//  Novigation
//
//  Created by Александр Хмыров on 13.09.2022.
//

import Foundation


protocol AppCoordinatorProtocol {

    // дерево дочерних координаторов у текущего координатора, дерево скринов
    // также может быть один координатор вместо массива
    // для того чтобы все держалось в памяти

    var childs: [AppCoordinatorProtocol] { get set }
 
}
