//
//  ViewModel.swift
//  HeroesAndVillains
//
//  Created by Admin on 6/4/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation

class ViewModel{
    
    var character: aCharacter!
    
    var characters = [marvelCharacter](){
        didSet{
            NotificationCenter.default.post(name: Notification.Name.CharacterNotification, object: nil)
        }
    }
    
    
    
//    var faveCharacters = [CoreFavoriteCharacter](){
//        didSet{
//            self.updateUI?()
//            NotificationCenter.default.post(name: Notification.Name.FaveCharactersNotification, object: nil)
//        }
//    }
    
    var comic = Comic()
    var updateUI: (()->Void)?
    
    
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
    
    var cvComics = [CVComic](){
        didSet{
            NotificationCenter.default.post(name: Notification.Name.CVComicsNotification, object: nil)
        }
    }
    
    var faveComics = [CoreComic](){
        didSet{
            self.updateUI?()
            NotificationCenter.default.post(name: Notification.Name.FaveComicsNotification, object: nil)
        }
    }
    
    
    
    
    
//    var characterStats = [CharacterStats](){
//        didSet{
//            NotificationCenter.default.post(name: Notification.Name.CharacterStatsNotification, object: nil)
//        }
//    }
    
//    var battleTeam = BattleTeam(){
//        didSet{
//            NotificationCenter.default.post(name: Notification.Name.BattleTeamNotification, object: nil)
//        }
//    }
    
//    init(){
//        GetFavoriteCharacters()
//    }
    
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
    
    
    
//    func saveCharacterToFaves(with char: aCharacter) -> Bool{
//        
//        return  coreManager.saveFavoriteCharacterToCore(with: char)!
//    }
//    
//    @discardableResult
//    func deleteCharacterFromFaves(with char: aCharacter) -> Bool{
//        // faveCharacters.removeAll { $0 === char         }
//        return coreManager.deleteFavoriteCharacterFromCore(withChar: char)
//    }
    
//    func deleteCharacterFromFaves(with char: CoreFavoriteCharacter) {
//        coreManager.deleteCharacter(withChar: char)
//        self.faveCharacters.removeAll { $0 === char }
//    }
    
    func getCharactersForComic(for comicID: Int){
        
        mvlService.getCharactersForComic(for: comicID){[unowned self] characters in
            
            self.comicCharacters = characters
            print("Character in comic Count: \(characters.count)")
        }
    }
    
//    func GetFavoriteCharacters(){
//        self.faveCharacters = coreManager.getCoreFavoriteCharacters()
//    }
    
//    func CheckFavedCharacters(with char: aCharacter) -> Bool{
//        
//        self.faveCharacters = coreManager.getCoreFavoriteCharacters()
//        print("Favorites:")
//        for aChar in self.faveCharacters{
//            let c = aCharacter(with:aChar)
//            print("Character: \(c.name)")
//        }
//        for aChar in self.faveCharacters{
//            let c = aCharacter(with:aChar)
//            print("Character from faves: \(c.name)")
//            if( c == char)
//            {
//                return true
//            }
//        }
//        
//        return false
//        
//    }
//    func isFaved(_ char: aCharacter) -> Bool {
//        return !faveCharacters.filter { $0.name == char.name }.isEmpty
//    }
    
    //MARK: Comics
    
//    func getComics(){
//        
//        mvlService.getComics(){ [unowned self] comics in
//            
//            self.comics = comics
//            print("Comics Count: \(comics.count)")
//        }
//    }
    
//    func getComicsForCharacter(for charID: Int, dateDescriptor period: String, forDate1 date1: String?, forDate2 date2: String?){
//
//        mvlService.getComicsForCharacter(for: charID, dateDescriptor: period, forDate1: date1, forDate2: date2){ [unowned self] comics in
//            
//            self.characterComics = comics
//            print("Comics Count: \(comics.count)")
//        }
//    }
    
    
    
    func getCVComicsWithName(name: String){
        cvService.getComicsWithName(name: name, completion: {[unowned self] comics in
            
            self.cvComics = comics
            print("CVComics Count: \(comics.count)")
        })
    }
    
    func saveComicToFaves(with comic: Comic) -> Bool{
        
        return  coreManager.saveComic(withComic: comic)
    }
    
    @discardableResult
    func deleteComicFromFaves(with comic: Comic) -> Bool{
        // faveCharacters.removeAll { $0 === char         }
        return coreManager.deleteComic(with: comic)
    }
    
    func deleteComicFromFaves(with comic: CoreComic) {
        coreManager.deleteComic(withCore: comic)
        faveComics.removeAll { $0 === comic }
    }
    
    func GetFavoriteComics(){
        self.faveComics = coreManager.getCoreComics()
    }
    
    func CheckFavedComics(with comic: Comic) -> Bool{
        
        self.faveComics = coreManager.getCoreComics()
        print("Favorites:")
        for aComic in faveComics{
            let c = Comic(with: aComic)
            print("Comic: \(c.title)")
        }
        for aComic in faveComics{
            let c = Comic(with: aComic)
            print("Comics from faves: \(c.title)")
            if( c == comic)
            {
                return true
            }
        }
        
        return false
    }
    func isFaved(_ comic: Comic) -> Bool {
        return !faveComics.filter { $0.title == comic.title }.isEmpty
    }
    
    //MARK: Videos
    
    
    
    //MARK: CharacterStats
    
//    func getCharacterStats(name: String){
//        let cleanName = name.addingPercentEncoding(withAllowedCharacters: CharacterSet.customAllowedURLCharacters())
//        csService.getCharacterStatsWithName(name: cleanName!, completion: {[unowned self] characterStats in
//            
//            self.characterStats = characterStats
//            print("Character Stats count: \(characterStats.count)")
//        })
//    }
    
    //MARK: Battle
    
//    func AddBattleCharacterToTeam(_ battleCharacter: BattleCharacter, _ battleTeamName: String){
//        
//        //Save battleCharacter to core data
//        
//        if battleTeam.battleCharacters.count < Constants.CoreBattleTeamKeysNum.battleTeamMaxSize.rawValue{
//            
//            battleTeam.battleCharacters.append(battleCharacter.id)
//        }
//        
//        //Save battleTeam to core data
//    }
}
