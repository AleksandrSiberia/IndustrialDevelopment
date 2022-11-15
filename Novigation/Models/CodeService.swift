//
//  CodeServise.swift
//  Novigation
//
//  Created by Александр Хмыров on 14.11.2022.
//

import Foundation


final class CodeService {

    static var shared = CodeService()


    private init() {

    }


    func encode(string: String) {

        let dataUrl = string.data(using: .utf8)


        var arrayUInt8: [UInt8] = []
        var arrayInt: [Int] = []

        for number in dataUrl! {
            arrayUInt8.append(number)
        }

        for number in arrayUInt8 {

            let int = Int(number) * 12 - 1234

            arrayInt.append(int)
        }

        print("🍇 arrayInt", arrayInt)
    }





    func decode(intArray: [Int]) -> String {

        var arrayUInt8: [UInt8] = []

        for number in intArray {

            let int = (number + 1234) / 12

            let uint8 = UInt8(int)

            arrayUInt8.append(uint8)
        }

        let string = String(bytes: arrayUInt8, encoding: .utf8)!

        return string

    }

}
