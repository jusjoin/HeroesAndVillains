//
//  HomeViewModel.swift
//  HeroesAndVillains
//
//  Created by Zane on 7/25/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation

class HomeViewModel{
    
    var topCharacters = [marvelCharacter](){
        didSet{
            NotificationCenter.default.post(name: Notification.Name.TopCharacterNotification, object: nil)
        }
    }
    
    var characterComics = [marvelComic](){
        didSet{
            NotificationCenter.default.post(name: Notification.Name.ComicsForNotification, object: nil)
        }
    }
    
    var comics = [marvelComic](){
        didSet{
            NotificationCenter.default.post(name: Notification.Name.ComicsNotification, object: nil)
        }
    }
    
    var dummyCharacters = [aCharacter](){
        didSet{
            NotificationCenter.default.post(name: Notification.Name.DummyCharactersNotification, object: nil)
        }
    }
    
    var featuredVideos = [CVideo](){
        didSet{
            NotificationCenter.default.post(name: Notification.Name.VideosNotification, object: nil)
        }
    }
    
    var videosForCharacter = [CVideo](){
        didSet{
            NotificationCenter.default.post(name: Notification.Name.VideosForNotification, object: nil)
        }
    }
    
    var updateUI: (()->Void)?
    
    var faveCharacters = [CoreFavoriteCharacter](){
        didSet{
            self.updateUI?()
            NotificationCenter.default.post(name: Notification.Name.FaveCharactersNotification, object: nil)
        }
    }
    
    func deleteCharacterFromFaves(with char: CoreFavoriteCharacter) {
        coreManager.deleteCharacter(withChar: char)
        self.faveCharacters.removeAll { $0 === char }
    }
    
    func CheckFavedCharacters(with char: aCharacter) -> Bool{
        
        self.faveCharacters = coreManager.getCoreFavoriteCharacters()
        print("Favorites:")
        for aChar in self.faveCharacters{
            let c = aCharacter(with:aChar)
            print("Character: \(c.name)")
        }
        for aChar in self.faveCharacters{
            let c = aCharacter(with:aChar)
            print("Character from faves: \(c.name)")
            if( c == char)
            {
                return true
            }
        }
        
        return false
        
    }
    func isFaved(_ char: aCharacter) -> Bool {
        return !faveCharacters.filter { $0.name == char.name }.isEmpty
    }
    
    func getTopCharacters(){
        
        for charName in MarvelVARS.TopCharacters{
            mvlService.getCharacterByFullName(fullName: charName){[unowned self] character in
                
                guard let thisCharacter = character.first else{
                    self.addDummyCharacter()
                    return
                }
                self.topCharacters.append(thisCharacter)
                print("Added \(thisCharacter.name) to top characters.")
                
            }
        }
    }
    
    func GetFavoriteCharacters(){
        self.faveCharacters = coreManager.getCoreFavoriteCharacters()
    }
    
    func getComicsLatest(dateDescriptor period: String, forDate1 date1: String?, forDate2 date2: String?){
        
        mvlService.getComicsLatest(dateDescriptor: period, forDate1: date1, forDate2: date2){ [unowned self] comics in
            
            self.comics = comics
            print("Comics Count: \(comics.count)")
        }
    }
    
    func addDummyCharacter(){
        dummyCharacters.append(aCharacter(id:dummyCharacters.count+1, name:"dummy", description: "This is not a character", image: "mask.png", alignment: "neutral"))
    }
    
    func getFeaturedVideos(){
        
        cvService.getLatestVideos(){ [unowned self] videos in
            
            self.featuredVideos = videos
            print("Videos Count: \(videos.count)")
        }
    }
    
}
