//
//  LoginViewControllerDelegate.swift
//  Novigation
//
//  Created by Александр Хмыров on 05.09.2022.
//

import Foundation


protocol LoginViewControllerDelegate {

    func checkCredentials(withEmail: String, password: String, completion: @escaping (String?) -> Void)
    
    func signUp(withEmail: String, password: String, completion: @escaping (String?) -> Void) 

}



