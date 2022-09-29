//
//  CustomError.swift
//  Novigation
//
//  Created by Александр Хмыров on 28.09.2022.
//

import Foundation


enum CustomErrorNovigation: Error {
    case invalidPasswordOrLogin

    case noPost
}


extension CustomErrorNovigation: CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalidPasswordOrLogin:
            return "Неправильный пароль или логин"
        case .noPost:
            return "Отсутствует контент"
        }
    }
}





