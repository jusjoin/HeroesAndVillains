//
//  ComicViewModel.swift
//  HeroesAndVillains
//
//  Created by Zane on 8/1/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation

class ComicViewModel{
    
    var comic = Comic()
    var updateUI: (()->Void)?
    
    var comicCharacters = [marvelCharacter](){
        didSet{
            NotificationCenter.default.post(name: Notification.Name.CharactersForNotification, object: nil)
        }
    }
    
    var faveComics = [CoreComic](){
        didSet{
            self.updateUI?()
            NotificationCenter.default.post(name: Notification.Name.FaveComicsNotification, object: nil)
        }
    }
    
    func getCharactersForComic(for comicID: Int){
        
        mvlService.getCharactersForComic(for: comicID){[unowned self] characters in
            
            self.comicCharacters = characters
            print("Character in comic Count: \(characters.count)")
        }
    }
    
    func isFaved(_ comic: Comic) -> Bool {
        return !faveComics.filter { $0.title == comic.title }.isEmpty
    }
    
    func saveComicToFaves(with comic: Comic) -> Bool{
        
        return  coreManager.saveComic(withComic: comic)
    }
    
    @discardableResult
    func deleteComicFromFaves(with comic: Comic) -> Bool{
        // faveCharacters.removeAll { $0 === char         }
        return coreManager.deleteComic(with: comic)
    }
}
