//
//  MarvelComic.swift
//  HeroesAndVillains
//
//  Created by Admin on 6/10/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation

struct ComicResults: Decodable {
    let data : SearchResults
}

struct SearchResults: Decodable {
    let results: [marvelComic]
    
    
    
}

class marvelComic: Decodable{
    let id : Int
    let title : String
    let issueNumber : Int
    let description : String?
    let upc : String
    let urls : [Urls]
    let prices : [Prices]
    let images : [Images]?
    //let creators : [Creators]?
    
}

struct Prices: Decodable{
    let type: String
    let price: Double
}

struct Images: Decodable{
    let path: String
    let extens: String
    
    private enum CodingKeys: String, CodingKey{
        case path
        case extens = "extension"
    }

}

struct Creators: Decodable{
    let collectionURI: String?
    let items: Items
}
