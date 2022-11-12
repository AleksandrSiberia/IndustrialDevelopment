//
//  ModelResident.swift
//  Novigation
//
//  Created by Александр Хмыров on 13.10.2022.
//

import Foundation



struct ModelResident: Codable {
    var name: String
}

class ManagerDataResidentsPlanet {
    
    static var residentsPlanet: [ModelResident] = []
    static var residentsPlanetUserDefaults: [ModelResident] = []
    
    
    static func saveResidentsPlanet() {
        do {
            let data = try JSONEncoder().encode(residentsPlanet)
            UserDefaults.standard.set(data, forKey: "dataResidentsPlanet")
            UserDefaults.standard.synchronize()
        }
        catch {
            print(error)
        }
    }
    
    static func loadResidentsPlanet() {
        
        do {
            guard let data = UserDefaults.standard.data(forKey: "dataResidentsPlanet") else {
                print("data = nil")
                return
            }
            ManagerDataResidentsPlanet.residentsPlanetUserDefaults = try JSONDecoder().decode([ModelResident].self, from: data)
            
        }
        catch {
            print(error)
        }
        
    }
}
