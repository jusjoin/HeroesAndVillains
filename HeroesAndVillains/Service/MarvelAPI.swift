//
//  MarvelAPI.swift
//  HeroesAndVillains
//
//  Created by Admin on 6/4/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation

struct MarvelAPI {
    
    static let base = "https://gateway.marvel.com:443/v1/public/"
    static let charactersMethod = "characters?"
    static let characterFullNameMethod = "characters?name="
    static let characterNameStartsWithMethod = "characters?nameStartsWith="
    static let comicsMethod = ""
    static let seriesMethod = ""
    static let eventsMethod = ""
    static let limit = 20
    static let offset = 0
    static let ts = String(Date().timeIntervalSince1970)
    static let publicKey = "ec1082c0a7d0c82057b98aab4e1a4a18"
    static let privateKey = "7eab78cecd6feda9c1948cf74af6a474cc021c50"
    static let hash = "&hash=" + (ts+privateKey+publicKey).md5
    
    static func getCharacters() -> String{
        
        print("Search Character URL: " + base + charactersMethod + "&ts=" + ts + "apikey=" + publicKey + hash + characterFullNameMethod + hash )
        
        return base + charactersMethod + "&ts=" + ts + "apikey=" + publicKey + hash + characterFullNameMethod + hash
    }
    
    static func getCharacterByFullNameURL(_ fullName: String) -> String{
        
        print("Search Character URL: " + base + characterFullNameMethod + fullName + "&ts=" + ts + "apikey=" + publicKey + hash + characterFullNameMethod + hash )
        
        return base + characterFullNameMethod + fullName + "&ts=" + ts + "apikey=" + publicKey + hash + characterFullNameMethod + hash
    }
    
    static func getCharacterByNameStartsWithURL(_ name: String) -> String{
        
        print("Search Character URL: " + base + characterNameStartsWithMethod + name + "&ts=" + ts + "apikey=" + publicKey + hash + characterFullNameMethod + hash )
        
        return base + characterFullNameMethod + name + "&ts=" + ts + "apikey=" + publicKey + hash + characterFullNameMethod + hash
    }
    
    
}
