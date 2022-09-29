//
//  CustomError.swift
//  Novigation
//
//  Created by Александр Хмыров on 28.09.2022.
//

import Foundation


enum CustomErrorNovigation: String, Error {

    case invalidPasswordOrLogin = "Неправильный пароль или логин"

    case noPost = "Отсутствует контент"

    case noWord = "Набрано неправильное слово"
}







