//
//  NetworkService.swift
//  Novigation
//
//  Created by Александр Хмыров on 07.10.2022.
//

import Foundation

enum AppConfiguration: String, CaseIterable {

    case url1 = "https://swapi.dev/api/people/1"
    case url2 = "https://swapi.dev/api/people/2"
    case url3 = "https://swapi.dev/api/people/3"

    static var url: String { AppConfiguration.allCases.randomElement()?.rawValue ?? self.url }
}


struct NetworkService {

    static func request(for configuration: String, completion: @escaping (_ people: [String: [String]]? ) -> Void ) {

        let url = URL(string: configuration)

        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: url!) { data, urlResponse, error in

            if error == nil, let data = data, let response = urlResponse as? HTTPURLResponse {
                print("\nDATA: \(String(decoding: data, as: UTF8.self))")
                print("\nRESPONSE STATUS: \(response.statusCode)")
                print("\nRESPONSE HEADER: \(response.allHeaderFields)")
            } else {
                print("\nERROR: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
        task.resume()
    }
}






