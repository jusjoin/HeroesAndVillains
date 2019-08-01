//
//  SearchViewModel.swift
//  HeroesAndVillains
//
//  Created by Zane on 7/25/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation

class SearchViewModel{
    
    var characters = [marvelCharacter](){
        didSet{
            NotificationCenter.default.post(name: Notification.Name.CharacterNotification, object: nil)
        }
    }
    
    var cvComics = [CVComic](){
        didSet{
            NotificationCenter.default.post(name: Notification.Name.CVComicsNotification, object: nil)
        }
    }
    
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
            
            if !characters.isEmpty{
                var newCharacters = [marvelCharacter]()
                for i in 0...characters.count-1{
                    if !self.characters.isEmpty{
                        if characters[i].id != self.characters[0].id{
                            newCharacters.append(characters[i])
                        }
                    }else{
                        newCharacters.append(characters[i])
                    }
                }
                
                self.characters += characters
                print("Character Count: \(characters.count)")
            }
        }
    }
    
    func getCVComicsWithName(name: String){
        cvService.getComicsWithName(name: name, completion: {[unowned self] comics in
            
            self.cvComics = comics
            print("CVComics Count: \(comics.count)")
        })
    }
}
