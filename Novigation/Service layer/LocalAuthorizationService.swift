//
//  LocalAuthorizationService.swift
//  Novigation
//
//  Created by Александр Хмыров on 24.12.2022.
//

import Foundation
import LocalAuthentication


class LocalAuthorizationService {


    enum TypesBiometricAuthentication {

        case none
        case faceID
        case touchID
        case unknown
    }
    

    private var currentTypeAuthentication: TypesBiometricAuthentication?

    private var error: NSError?


    lazy var context: LAContext = {
        return LAContext()
    }()



    lazy var biometricType: TypesBiometricAuthentication = {

        let type = self.context.biometryType


        switch type {

        case .none:
            return .none

        case .touchID:
            return  .touchID

        case .faceID:
            return .faceID

        @unknown default:
            return .unknown
        }
    }()



    lazy var policy: LAPolicy = {
        return .deviceOwnerAuthenticationWithBiometrics
    }()



    init() {

        self.canEvaluateBiometric { bool, error in
            print("🚗", bool, error?.localizedDescription)
        }
    }



    func canEvaluateBiometric(_ authorizationFinished: @escaping (Bool, NSError?) -> Void) {

        guard self.context.canEvaluatePolicy(self.policy, error: &self.error) else {

            if let error {

                self.error = error

                return authorizationFinished( false, error )
            }

            return authorizationFinished( false, error )
        }

        return authorizationFinished( true, error)
    }


    
    func evaluateBiometric() {


    }
}


