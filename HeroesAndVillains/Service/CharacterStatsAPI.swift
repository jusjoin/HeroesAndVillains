//
//  SuperHeroStatsAPI.swift
//  HeroesAndVillains
//
//  Created by Zane on 6/28/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation

struct CharacterStatsAPI{
    
    static let base = "https://www.superheroapi.com/api.php/"
    static let apiKey = "10156071258215741/"
    static let searchMethod = "search/"
    static let statsMethod = "powerstats"
    static let biographyMethod = "biography"
    static let appearanceMethod = "appearance"
    static let workMethod = "work"
    
    //MARK: Characters
    
    static func getCharactersWithNameURL(name: String) -> String{
        
        let escFullName = name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let url = base + apiKey + searchMethod + escFullName
        print("Get Power Stats URL: " + url)
        return url
    }
    
    static func getCharactersWithIDURL(id: Int) -> String{
        
        let url = base + apiKey + String(id)
        print("Get Character URL: " + url)
        return url
    }
}
