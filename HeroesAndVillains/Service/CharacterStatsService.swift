//
//  CharacterStatsService.swift
//  HeroesAndVillains
//
//  Created by Zane on 6/28/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation

typealias CStatsHandler = ([CharacterStats]) -> Void
let csService = CharacterStatsService.shared

final class CharacterStatsService{
    
    static let shared = CharacterStatsService()
    
    lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        return URLSession(configuration: config)
    }()


    func getCharacterStatsWithName(name: String, completion: @escaping CStatsHandler){
        
        let urlString = CharacterStatsAPI.getCharactersWithNameURL(name: name)
        
        guard let finalURL = URL(string: urlString) else {
            completion([])
            return
        }
        
        session.dataTask(with: finalURL) { (dat, _, _) in
            
            if let data = dat {
                
                do {
                    let response = try JSONDecoder().decode(CharacterStatsResult.self, from: data)
                    
                    let characterStats = response.results
                    
                    completion(characterStats)
                    
                } catch let err {
                    completion([])
                    print("Decoding Error: \(err.localizedDescription)")
                }
                
            }
            
            }.resume()
    }

}
