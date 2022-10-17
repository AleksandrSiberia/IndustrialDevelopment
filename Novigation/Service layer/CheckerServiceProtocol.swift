//
//  CheckerServiceProtocol.swift
//  Novigation
//
//  Created by Александр Хмыров on 17.10.2022.
//

import Foundation
import FirebaseAuth


protocol CheckerServiceProtocol {

    func checkCredentials(withEmail: String, password: String, completion: @escaping (String?) -> Void )
    
    func signUp(withEmail: String, password: String, completion: @escaping (String?) -> Void )
}


