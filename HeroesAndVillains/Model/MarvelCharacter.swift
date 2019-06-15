//
//  Character.swift
//  HeroesAndVillains
//
//  Created by Admin on 6/4/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation

struct CharacterResults: Decodable {
    let data : Results
}

struct Results: Decodable {
    let results: [marvelCharacter]
}

class marvelCharacter: Decodable{
    
    let id: Int
    let name: String
    let description: String
    let modified: String
    let thumbnail: Thumbnail
    let resourceURI: String
    let comics: Comics
    let series: Series
    let stories: Stories
    let events : Events
    let urls: [Urls]
    
}

struct Thumbnail: Decodable{

    let path: String
    let extens: String

    private enum CodingKeys: String, CodingKey{
        case path
        case extens = "extension"
    }
}

class Comics: Decodable{

    let available: Int
    let collectionURI: String
    let items: [Items]
}

struct Items: Decodable{

    let resourceURI: String
    let name: String
    let role: String?
}

struct Series: Decodable{

    let available: Int
    let collectionURI: String
    let items: [Items]
}

struct Stories: Decodable{

    let available: Int
    let collectionURI: String
    let items: [Items]
}

struct Events: Decodable{

    let available: Int
    let collectionURI: String
    let items: [Items]
}

struct Urls: Decodable{
    let type: String
    let url: String
}
