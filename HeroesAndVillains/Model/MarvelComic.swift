//
//  MarvelComic.swift
//  HeroesAndVillains
//
//  Created by Admin on 6/10/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation

struct SearchResults: Decodable {
    let data : ComicResults
}

struct ComicResults: Decodable {
    let results: [marvelComic]
    
    
    
}

class marvelComic: Decodable{
    let id : Int
    let title : String
    let issueNumber : Int
    let description : String
    let upc : String
    let urls : [Urls]
    let prices : [Prices]
    let image : [Images]
    let creators : [Creators]
    
}

struct Prices: Decodable{
    
}

struct Images: Decodable{
    
    
}

struct Creators: Decodable{
    
}
