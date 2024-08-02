//
//  NetworkManager.swift
//  superHero
//
//  Created by Muhammed Siddiqui on 7/31/24.
//

import Foundation

public class NetworkManager {
    // Making a shared Instance so that all the instances can of view can get the value
    static let shared: NetworkManager = NetworkManager()
    
    private init() {
        
    }
    
    func getSuperHero(completion: @escaping ((SuperHeroModel?)->Void)) {
        guard let url = URL(string: "https://run.mocky.io/v3/4e11137d-42fc-4990-8828-c40b3fa14ce4") else {
            debugPrint("Error: The URL is not proper ")
            completion(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                debugPrint("Error: The APi call failed reason  -  \(error)")
                completion(nil)
            } else {
                if let validData = data, validData.count > 0 {
                    do {
                        let result = try JSONDecoder().decode(SuperHeroModel.self, from: validData)
                        completion(result)
                    } catch {
                        debugPrint("Error: Happend while Data Decoding \(error)")
                    }
                } else {
                    debugPrint("Error: No data fount response found \(String(describing: response))")
                }
            }
        }
        task.resume()
    }
}
