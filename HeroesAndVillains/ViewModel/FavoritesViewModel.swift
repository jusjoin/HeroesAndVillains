//
//  FavoritesViewModel.swift
//  HeroesAndVillains
//
//  Created by Zane on 7/25/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation

class FavoritesViewModel{
    
    var updateUI: (()->Void)?
    
    var faveCharacters = [CoreFavoriteCharacter](){
        didSet{
            self.updateUI?()
            NotificationCenter.default.post(name: Notification.Name.FaveCharactersNotification, object: nil)
        }
    }
    
    func GetFavoriteCharacters(){
        self.faveCharacters = coreManager.getCoreFavoriteCharacters()
    }
    
    func deleteCharacterFromFaves(with char: CoreFavoriteCharacter) {
        coreManager.deleteCharacter(withChar: char)
        self.faveCharacters.removeAll { $0 === char }
    }
    
    var faveComics = [CoreComic](){
        didSet{
            self.updateUI?()
            NotificationCenter.default.post(name: Notification.Name.FaveComicsNotification, object: nil)
        }
    }
    
    func GetFavoriteComics(){
        self.faveComics = coreManager.getCoreComics()
    }
    
    func deleteComicFromFaves(with comic: CoreComic) {
        coreManager.deleteComic(withCore: comic)
        faveComics.removeAll { $0 === comic }
    }
}
