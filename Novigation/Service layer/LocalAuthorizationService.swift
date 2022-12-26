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


    
    func evaluateBiometric(completion: @escaping (Bool, NSError?) -> Void ) {

        self.context.evaluatePolicy(self.policy, localizedReason: "Подтвердите свою личность") { bool, error in

            DispatchQueue.main.async {

                guard bool == true

                else {

                    if let error {
                        completion(false, error as NSError)
                        return
                    }
                    else {
                        completion(false, nil)
                        return
                    }
                }
                completion(true, nil)

            }
        }
    }
}


