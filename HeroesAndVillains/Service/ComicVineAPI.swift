//
//  ComicVineAPI.swift
//  HeroesAndVillains
//
//  Created by Zane on 6/14/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation

struct ComicVineAPI{
    
    static let base = "http://comicvine.gamespot.com/api/"
    static let apikey = "85c95e6fbdd72286d1a406540959d8fb0bab266c"
    static let charactersMethod = "characters/"
    static let comicsMethod = "issues/"
    static let videosMethod = "videos/"
    static let moviesMethod = "movies/"
    
    //MARK: Characters
    
    static func getCharactersURL() -> String{
        
        let url = base + charactersMethod
    }
}
