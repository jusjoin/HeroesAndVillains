//
//  CharacterViewModel.swift
//  HeroesAndVillains
//
//  Created by Zane on 7/25/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation

class CharacterViewModel{
    
    var comicPeriodDateDescriptor = "thisMonth"
    var comicPeriodDate1 = String()
    var comicPeriodDate2 = String()
    
    var character: aCharacter!{
        didSet{
            
        }
    }
    
    var characterComics = [marvelComic](){
        didSet{
            NotificationCenter.default.post(name: Notification.Name.ComicsForNotification, object: nil)
        }
    }
    
    var updateUI: (()->Void)?
    
    var faveCharacters = [CoreFavoriteCharacter](){
        didSet{
            self.updateUI?()
            NotificationCenter.default.post(name: Notification.Name.FaveCharactersNotification, object: nil)
        }
    }
    
    var characterStats = [CharacterStats](){
        didSet{
            NotificationCenter.default.post(name: Notification.Name.CharacterStatsNotification, object: nil)
        }
    }
    
    var battleTeam = BattleTeam(){
        didSet{
            NotificationCenter.default.post(name: Notification.Name.BattleTeamNotification, object: nil)
        }
    }
    
    func GetFavoriteCharacters(){
        self.faveCharacters = coreManager.getCoreFavoriteCharacters()
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
    
    func saveCharacterToFaves(with char: aCharacter) -> Bool{
        
        return  coreManager.saveFavoriteCharacterToCore(with: char)!
    }
    
    @discardableResult
    func deleteCharacterFromFaves(with char: aCharacter) -> Bool{
        // faveCharacters.removeAll { $0 === char         }
        return coreManager.deleteFavoriteCharacterFromCore(with: char)
    }
    
    func isFaved(_ char: aCharacter) -> Bool {
        return !faveCharacters.filter { $0.name == char.name }.isEmpty
    }
    
    func getComicsForCharacter(for charID: Int, dateDescriptor period: String, forDate1 date1: String?, forDate2 date2: String?){
        
        mvlService.getComicsForCharacter(for: charID, dateDescriptor: period, forDate1: date1, forDate2: date2){ [unowned self] comics in
            
            self.characterComics = comics
            print("Comics Count: \(comics.count)")
        }
    }
    
    func getCharacterStats(name: String){
        let cleanName = name.addingPercentEncoding(withAllowedCharacters: CharacterSet.customAllowedURLCharacters())
        csService.getCharacterStatsWithName(name: cleanName!, completion: {[unowned self] characterStats in
            
            self.characterStats = characterStats
            print("Character Stats count: \(characterStats.count)")
        })
    }
    
    func AddBattleCharacterToTeam(_ battleCharacter: BattleCharacter, _ battleTeamName: String){
        
        //Save battleCharacter to core data
        
        if battleTeam.battleCharacters.count < Constants.CoreBattleTeamKeysNum.battleTeamMaxSize.rawValue{
            
            battleTeam.battleCharacters.append(battleCharacter.id)
        }
        
        //Save battleTeam to core data
    }
}
