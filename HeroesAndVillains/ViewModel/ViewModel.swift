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
    
    
    //MARK: Comics
    
    func getComics(){
        
        mvlService.getComics(){ [unowned self] comics in
            
            self.comics = comics
            print("Comics Count: \(comics.count)")
        }
    }
    
    func getComicsForCharacter(for charID: Int, dateDescriptor period: String, forDate1 date1: String?, forDate2 date2: String?){

        mvlService.getComicsForCharacter(for: charID, dateDescriptor: period, forDate1: date1, forDate2: date2){ [unowned self] comics in
            
            self.comics = comics
            print("Comics Count: \(comics.count)")
        }
    }
    
    func getComicsLatest(dateDescriptor period: String, forDate1 date1: String?, forDate2 date2: String?){
        
        mvlService.getComicsLatest(dateDescriptor: period, forDate1: date1, forDate2: date2){ [unowned self] comics in
            
            self.comics = comics
            print("Comics Count: \(comics.count)")
        }
    }
}
