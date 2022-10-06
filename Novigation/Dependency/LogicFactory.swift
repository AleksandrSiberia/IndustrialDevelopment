//
//  LogicFactory.swift
//  Novigation
//
//  Created by Александр Хмыров on 05.09.2022.
//

import Foundation

protocol LogicFactory {
    func makeLoginInspector() -> LoginInspector
}
