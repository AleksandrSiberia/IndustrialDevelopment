//
//  MyLoginFactory.swift
//  Novigation
//
//  Created by Александр Хмыров on 31.08.2022.
//


import Foundation


struct MyLoginFactory: LogicFactoryProtocol {
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}



