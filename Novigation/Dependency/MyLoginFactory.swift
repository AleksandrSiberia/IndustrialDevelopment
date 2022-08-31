//
//  MyLoginFactory.swift
//  Novigation
//
//  Created by Александр Хмыров on 31.08.2022.
//

import Foundation

protocol LogicFactory {
    func makeLoginInspector() -> LoginInspector
}

struct MyLoginFactory: LogicFactory {
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}



