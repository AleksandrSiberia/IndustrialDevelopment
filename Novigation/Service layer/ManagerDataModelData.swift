//
//  ModelData.swift
//  Novigation
//
//  Created by Александр Хмыров on 11.10.2022.
//

import Foundation

class ManagerDataModelData {

    static func requestForModelData(_ completion: @escaping ((String?) -> Void )) {

        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/")
        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: url!) { data, response, error in
            if let error {
                print(error)
                completion(nil)
            }
            if (response as? HTTPURLResponse)?.statusCode != 200 {
                print("response statusCode= \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
                completion(nil)
            }
            guard let data else {
                print("ManagerDataModelData: data = nil")
                completion(nil)
                return
            }

            do {
                let answer = try JSONSerialization.jsonObject(with: data) as? [Any]
                let answerString = ((answer?[Int.random(in: 1...100)] as? [String: Any])?["title"]) as! String
                completion(answerString)
                return
            }

            catch {
                print(error)
            }
            completion(nil)
        }
        task.resume()
    }

}
