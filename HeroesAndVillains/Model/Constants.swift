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
        case homeGameTitle = "Clash"
        case comicsTitle = "Comics"
        case charactersTitle = "Characters"
        case gameMainTitle = "Clash Main"
        case gameBattleTitle = "Battle"
        
        
        case CoreFavoriteCharacter = "CoreFavoriteCharacter"
        case CoreComic = "CoreComic"
        case CoreMarvelCharacter = "CoreMarvelCharacter"
        case CoreMarvelComic = "CoreMarvelComic"
        case CoreBattleTeam = "CoreBattleTeam"
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
    
    enum CoreBattleTeamKeys: String{
        
        case DefaultBattleTeam1Name = "Team Alpha"
        case DefaultBattleTeam2Name = "Team Bravo"
        case DefaultBattleTeam3Name = "Team Charlie"
        case battleCharacters = "battleCharacters"
        case teamName = "teamName"
    }
    
    enum CoreBattleTeamKeysNum: Int{
        
        case battleTeamMaxSize = 3
    }
}
