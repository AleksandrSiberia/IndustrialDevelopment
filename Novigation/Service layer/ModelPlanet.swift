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



func requestModelPlanet(completion: @escaping ((String?) -> Void)) {

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
            print("data = nil")
            completion(nil)
            return
        }

        do {
            let planet = try JSONDecoder().decode(ModelPlanet.self, from: data)
            completion(planet.orbitalPeriod)
        }

        catch {
            print(error)
            completion(nil)
            return
        }

    }
    task.resume()
}

