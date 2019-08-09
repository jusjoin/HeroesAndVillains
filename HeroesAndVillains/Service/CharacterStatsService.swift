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
    
//    lazy var session: URLSession = {
//        let config = URLSessionConfiguration.default
//        config.timeoutIntervalForRequest = 30
//        return URLSession(configuration: config)
//    }()


    func getCharacterStatsWithName(name: String, completion: @escaping CStatsHandler){
        
        let urlString = CharacterStatsAPI.getCharactersWithNameURL(name: name)
        
        let apiCaller = WebAPICaller()
        apiCaller.getCharacterStatsData(urlString: urlString, completion: {[] cStats in
            
            completion(cStats)
        })
    }

}
