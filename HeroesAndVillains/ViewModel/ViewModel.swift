//
//  ViewModel.swift
//  HeroesAndVillains
//
//  Created by Admin on 6/4/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation

class ViewModel{
    
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
    
    var comics = [marvelComic](){
        didSet{
            NotificationCenter.default.post(name: Notification.Name.ComicsNotification, object: nil)
        }
    }
    
    var characterComics = [marvelComic]()
    
    //MARK: Characters
    
    func getCharacters(){
        mvlService.getCharacters(){ [unowned self] characters in
            
            self.characters = characters
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
    
    func getComicsForCharacter(){
        //TODO
        print("{{{ ViewModel.getComicsForCharacter: NOT IMPLEMENTED }}}")
    }
}
