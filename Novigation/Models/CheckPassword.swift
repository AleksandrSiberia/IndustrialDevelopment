//
//  PasswordSelection.swift
//  Novigation
//
//  Created by Александр Хмыров on 24.09.2022.
//

import Foundation

protocol LoginViewControllerOutput {
    func bruteForce()
}

protocol CheckPasswordOutput {

    func activityIndicatorOn()
    func activityIndicatorOff()
}

class CheckPassword: LoginViewControllerOutput {

    var view: CheckPasswordOutput?

    var password = "05HFIO"

    var s1: String?
    var s2: String?
    var s3: String?
    var s4: String?
    var s5: String?
    var s6: String?


    var symbols = ""

    var thisIsPassword = ""

    var arraySymbols: [String] = [
        "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",

        "A", "E", "I", "O", "U", "Y","B", "C", "D", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "X", "Y", "Z",

        //        "a", "e", "i", "o", "u", "y","b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z"
    ]


    func bruteForce() {

        
        self.view?.activityIndicatorOn()

        let dispatchQueue = DispatchQueue.init(label: "checkArraySymbols", qos: .userInitiated)
        let workItem = DispatchWorkItem { [self] in


            while(self.thisIsPassword != self.password) {

                for number in self.arraySymbols {
                    s1 = number
                    let numberString = "\(s1!)"
                    self.symbols = numberString
                    print(self.symbols)
                    if self.password == self.symbols {
                        self.thisIsPassword = self.symbols
                        print("Пароль: \(self.symbols)")
                        return
                    }

                    for number in self.arraySymbols {
                        s2 = number
                        let numberString = "\(s1!)\(s2!)"
                        self.symbols = numberString
                        print(self.symbols)
                        if password == self.symbols {
                            self.thisIsPassword = self.symbols
                            print("Пароль: \(self.symbols)")
                            return
                        }

                        for number in self.arraySymbols {
                            s3 = number
                            let numberString = "\(s1!)\(s2!)\(s3!)"
                            self.symbols = numberString

                            if password == self.symbols {
                                self.thisIsPassword = self.symbols
                                print("Пароль: \(self.symbols)")
                                return
                            }

                            for number in self.arraySymbols {
                                s4 = number
                                let numberString = "\(s1!)\(s2!)\(s3!)\(s4!)"
                                self.symbols = numberString
                                if password == self.symbols {
                                    self.thisIsPassword = self.symbols
                                    print("Пароль: \(self.symbols)")
                                    return
                                }

                                for number in self.arraySymbols {
                                    s5 = number
                                    let numberString = "\(s1!)\(s2!)\(s3!)\(s4!)\(s5!)"
                                    self.symbols = numberString
                                    print(self.symbols)
                                    if password == self.symbols {
                                        self.thisIsPassword = self.symbols
                                        print("Пароль: \(self.symbols)")
                                        return
                                    }

                                    for number in self.arraySymbols {
                                        s6 = number
                                        let numberString = "\(s1!)\(s2!)\(s3!)\(s4!)\(s5!)\(s6!)"
                                        self.symbols = numberString
                                        if password == self.symbols {
                                            self.thisIsPassword = self.symbols
                                            print("Пароль: \(self.symbols)")
                                            return
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        dispatchQueue.async(execute: workItem)

    }
}




