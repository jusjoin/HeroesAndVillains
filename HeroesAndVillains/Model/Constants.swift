//
//  Constants.swift
//  HeroesAndVillains
//
//  Created by Admin on 6/3/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation

struct Constants{
    
    enum Keys: String{
        
        case HeroesAndVillains = "HeroesAndVillains"
        case homeTitle = "Home"
        case searchTitle = "Search"
        case favoritesTitle = "Favorites"
        case defaultComicImage = "mask.png"
        case homeVCIdentifier = "HomeViewController"
        case characterDetailsVCIdentifier = "CharacterDetailsViewController"
        
        case CoreCharacter = "CoreCharacter"
        case CoreComic = "CoreComic"
        case CoreMarvelCharacter = "CoreMarvelCharacter"
        case CoreMarvelComic = "CoreMarvelComic"
    }
    
    enum CoreCharacterKeys: String{
        
        case id = "id"
        case alignment = "alignment"
        case descript = "descript"
        case image = "image"
        case name = "name"
    }
    
    enum CoreComicKeys: String{
        
        case id = "id"
        case title = "title"
        case descript = "descript"
        case upc = "upc"
        case image = "image"
        case issueNumber = "issueNumber"
        case price = "price"
        case creators = "creators"
    }
    
}
