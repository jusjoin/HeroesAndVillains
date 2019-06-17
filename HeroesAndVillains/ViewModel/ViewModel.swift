//
//  ViewModel.swift
//  HeroesAndVillains
//
//  Created by Admin on 6/4/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation

class ViewModel{
    
    var character = aCharacter()
    
    var characters = [marvelCharacter](){
        didSet{
            NotificationCenter.default.post(name: Notification.Name.CharacterNotification, object: nil)
        }
    }
    
    var topCharacters = [marvelCharacter](){
        didSet{
            NotificationCenter.default.post(name: Notification.Name.TopCharacterNotification, object: nil)
        }
    }
    
    var faveCharacters = [CoreCharacter](){
        didSet{
            NotificationCenter.default.post(name: Notification.Name.FaveCharactersNotification, object: nil)
        }
    }
    
    var comic = Comic()
    
    var comics = [marvelComic](){
        didSet{
            NotificationCenter.default.post(name: Notification.Name.ComicsNotification, object: nil)
        }
    }
    
    var characterComics = [marvelComic](){
        didSet{
            NotificationCenter.default.post(name: Notification.Name.ComicsForNotification, object: nil)
        }
    }
    
    var comicCharacters = [marvelCharacter](){
        didSet{
            NotificationCenter.default.post(name: Notification.Name.CharactersForNotification, object: nil)
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
    
    //MARK: Characters
    
    func getCharacters(){
        mvlService.getCharacters(){ [unowned self] characters in
            
            self.characters = characters
            print("Character Count: \(characters.count)")
        }
    }
    
    func getCharactersByName(name: String){
        mvlService.getCharacterByFullName(fullName: name){ [unowned self] characters in
            
            self.characters = characters
            print("Character Count: \(characters.count)")
        }
        
        mvlService.getCharacterByNameStartsWith(fullName: name){ [unowned self] characters in
            
            self.characters += characters
            print("Character Count: \(characters.count)")
        }
    }
    
    func getTopCharacters(){


        for charName in MarvelVARS.TopCharacters{
            mvlService.getCharacterByFullName(fullName: charName){[unowned self] character in
                
                guard let thisCharacter = character.first else{
                    return
                }
                self.topCharacters.append(thisCharacter)
                print("Added \(thisCharacter.name) to top characters.")
                
            }
        }
    }
    
    func saveCharacterToFaves(with char: aCharacter) -> Bool{
        
        return coreManager.saveCharacter(with: char)!
    }
    
    func deleteCharacterFromFaves(with char: aCharacter) -> Bool{
        
        return coreManager.deleteCharacter(withChar: char)
    }
    
    
    func getCharactersForComic(for comicID: Int){
        
        mvlService.getCharactersForComic(for: comicID){[unowned self] characters in
            
            self.comicCharacters = characters
            print("Character in comic Count: \(characters.count)")
        }
    }
    
    func GetFavoriteCharacters(){
        
        self.faveCharacters = coreManager.getCoreCharacters()
    }
    
    func CheckFavedCharacters(with char: aCharacter) -> Bool{
        
        self.faveCharacters = coreManager.getCoreCharacters()
        print("Favorites:")
        for aChar in faveCharacters{
            let c = aCharacter(with:aChar)
            print("Character: \(c.name)")
        }
        for aChar in faveCharacters{
            let c = aCharacter(with:aChar)
            print("Character from faves: \(c.name)")
            if( c == char)
            {
                return true
            }
        }
        
        return false
    }
    
    //MARK: Comics
    
    func getComics(){
        
        mvlService.getComics(){ [unowned self] comics in
            
            self.comics = comics
            print("Comics Count: \(comics.count)")
        }
    }
    
    func getComicsForCharacter(for charID: Int, dateDescriptor period: String, forDate1 date1: String?, forDate2 date2: String?){

        mvlService.getComicsForCharacter(for: charID, dateDescriptor: period, forDate1: date1, forDate2: date2){ [unowned self] comics in
            
            self.characterComics = comics
            print("Comics Count: \(comics.count)")
        }
    }
    
    func getComicsLatest(dateDescriptor period: String, forDate1 date1: String?, forDate2 date2: String?){
        
        mvlService.getComicsLatest(dateDescriptor: period, forDate1: date1, forDate2: date2){ [unowned self] comics in
            
            self.comics = comics
            print("Comics Count: \(comics.count)")
        }
    }
    
    func getFeaturedVideos(){
        
        cvService.getLatestVideos(){ [unowned self] videos in
            
            self.featuredVideos = videos
            print("Videos Count: \(videos.count)")
        }
    }
}
