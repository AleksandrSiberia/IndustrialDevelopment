//
//  ModelPlanet.swift
//  Novigation
//
//  Created by Александр Хмыров on 12.10.2022.
//

import Foundation

struct ModelPlanet: Decodable {

    var name: String
    var rotationPeriod: String
    var orbitalPeriod: String
    var diameter: String
    var climate: String
    var gravity: String
    var terrain: String
    var surfaceWater: String
    var population: String
    var residents: [String]
    var films: [String]
    var created: String
    var edited: String
    var url: String

    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter
        case climate
        case gravity
        case terrain
        case surfaceWater = "surface_water"
        case population
        case residents
        case films
        case created
        case edited
        case url
    }
}



class ManagerDataModelPlanet {

    static func requestModelPlanet(completion: @escaping ((ModelPlanet?) -> Void)) {

        guard let url = URL(string: "https://swapi.dev/api/planets/1") else { return }
        let session = URLSession(configuration: .default)


        let task = session.dataTask(with: url) { data, response, error in

            if let error {
                print(error)
                completion(nil)
            }

            if (response as? HTTPURLResponse)?.statusCode != 200 {
                print("response.statusCode = \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
                completion(nil)
            }

            guard let data else {
                print("ManagerDataModelPlanet: data = nil")
                completion(nil)
                return
            }

            do {
                let planet = try JSONDecoder().decode(ModelPlanet.self, from: data)
                completion(planet)


                for resident in planet.residents {

                    guard let url = URL(string: resident) else {
                        print("url = nil")
                        return
                    }
                    let session = URLSession(configuration: .default)

                    let task = session.dataTask(with: url) { data2, response, error in
                        if let error {
                            print(error)
                        }
                        if (response as? HTTPURLResponse)?.statusCode != 200 {
                            print("Response statusCode = \(String(describing: (response as? HTTPURLResponse)?.statusCode))" )
                        }
                        guard let data2 else {
                            print("data = nil")
                            return
                        }
                        do {

                            _ = try JSONDecoder().decode(ModelResident.self, from: data2)

                           
                       //     ManagerDataResidentsPlanet.residentsPlanet.append(resident)
                   //         ManagerDataResidentsPlanet.saveResidentsPlanet()
                        }

                        catch {
                            print(error)
                        }
                    }
                    task.resume()
                }

            }
            catch {
                print(error)
                completion(nil)
                return
            }
        }
        task.resume()
    }

}
