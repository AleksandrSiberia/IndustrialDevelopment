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

//            if let error {
//                print(error.localizedDescription)
//                completion(nil)
//            }
//
//            if (urlResponse as? HTTPURLResponse)?.statusCode != 200 {
//                print("Status code != 200, statusCode = \(String(describing: (urlResponse as? HTTPURLResponse)?.statusCode))")
//                completion(nil)
//            }
//
//            guard let data else
//            {
//                print("data = nil")
//                completion(nil)
//                return
//            }
//
//
//            do {
//
//                let answer = try JSONSerialization.jsonObject(with: data) as! [ String: Any]
//
//                var dictionaryActor: [ String: [String] ] = [:]
//
//                for (key, value) in answer {
//                    if key != "starships" || key != "films" || key != "vehicles"  {
//                        let any = [(value as? String)]
//                        if any != [nil] {
//                            dictionaryActor[key] = (any as! [String])
//                        }
//                    }
//                }
//
//
//                let starships = answer["starships"] as! [ Any ]
//                var starshipsString: [String] = []
//                for url in starships {
//                    starshipsString.append(url as! String)
//                }
//                dictionaryActor["starships"] = starshipsString
//
//
//                let films = answer["films"] as! [ Any ]
//                var filmsString: [String] = []
//                for url in films {
//                    filmsString.append((url as! String))
//                }
//                dictionaryActor["films"] = filmsString
//
//
//                let vehicles = answer["vehicles"] as! [ Any ]
//                var vehiclesString: [String] = []
//                for url in vehicles {
//                    vehiclesString.append((url as! String))
//                }
//                dictionaryActor["vehicles"] = vehiclesString
//
//                completion( dictionaryActor )
//                return
//
//            }
//            catch{
//                print(error.localizedDescription)
//            }
//            completion(nil)

        task.resume()
    }
}




