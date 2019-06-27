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
    static let apiKey = "api_key=85c95e6fbdd72286d1a406540959d8fb0bab266c"
    static let charactersMethod = "characters/"
    static let comicsMethod = "issues/"
    static let videosMethod = "videos/"
    static let moviesMethod = "movies/"
    static let format = "&format=json"
    static let filterMethod = "&filter="
    static let nameFilter = "name:"
    static let sortMethod = "&sort="
    
    //MARK: Characters
    
    static func getCharactersURL() -> String{
        
        let url = base + charactersMethod + "?" + apiKey + format
        print("Get Characters URL: " + url)
        return url
    }
    
    
    //MARK: Videos
    
    static func getVideosURL() -> String{
    
        let filters = "video_type:featured"
        let sortOn = "publish_date:desc"
        let url = base + videosMethod + "?" + apiKey + format + filterMethod + filters + sortMethod + sortOn
        print("Get Videos URL: " + url)
        return url
    }
    
    //Mark:// Comics
    
    static func getComicsURL() -> String{
        
        let url = base + comicsMethod + apiKey + format
        print("Get Comics URL: " + url)
        return url
    }
    
    static func getComicsWithNameURL(name: String) -> String{
        
        let nameFilter = "name:"
        let url = base + comicsMethod + "?" + apiKey + format + filterMethod + nameFilter + name
        print("Get Comics URL: " + url)
        return url
    }
}
