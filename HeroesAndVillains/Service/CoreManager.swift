//
//  CoreManager.swift
//  HeroesAndVillains
//
//  Created by Zane on 6/15/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation
import CoreData

let coreManager = CoreManager.sharedInstance

final class CoreManager
{
    static let sharedInstance = CoreManager()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: Constants.Keys.HeroesAndVillains.rawValue)
        
        
        container.loadPersistentStores(completionHandler: { (persistentStore, err) in
            if let error = err {
                fatalError("Unable to load persistent store.")
            }
        })
        
        
        return container
    }()
    
    //MARK: CoreCharacters
    
    func getCoreFavoriteCharacters() -> [CoreFavoriteCharacter]{
        
        //fetch request
        let fetchRequest = NSFetchRequest<CoreFavoriteCharacter>(entityName: Constants.Keys.CoreFavoriteCharacter.rawValue)
        
        //container
        var coreCharacters = [CoreFavoriteCharacter]()
        
        do {
            
            coreCharacters = try context.fetch(fetchRequest)
            print("CoreCharacters Count: \(coreCharacters.count)")
            return coreCharacters
            
        } catch {
            
            return []
        }
    }
    
    func saveFavoriteCharacterToCore(with char: aCharacter) -> Bool?{
        
        let savedCharacters = getCoreFavoriteCharacters()

        //entity description
        let entity = NSEntityDescription.entity(forEntityName: Constants.Keys.CoreFavoriteCharacter.rawValue, in: context)!
        
        //core entity
        let coreCharacter = NSManagedObject(entity: entity, insertInto: context)
        
        coreCharacter.setValue(char.id, forKey: Constants.CoreCharacterKeys.id.rawValue)
        //coreCharacter.setValue(char.alignment, forKey: Constants.CoreCharacterKeys.alignment.rawValue)
        coreCharacter.setValue(char.description, forKey: Constants.CoreCharacterKeys.descript.rawValue)
        coreCharacter.setValue(char.image, forKey: Constants.CoreCharacterKeys.image.rawValue)
        coreCharacter.setValue(char.name, forKey: Constants.CoreCharacterKeys.name.rawValue)
        
        
        //check if exists in core data
        for aChar in savedCharacters{
            let ch = aCharacter(with:aChar)
            if( ch == char)
            {
                context.delete(coreCharacter)
                print("Character: \(aChar.name) already exists in core data.")
                return false
            }
        }
        
        //save context
        saveContext()
        print("Saved Character To Core: \(char.name)")
        return true
        
    }
    
    //MARK: Delete
    func deleteCharacterFromCore(withCore char: CoreFavoriteCharacter) {
        
        context.delete(char)
        
        print("Deleted From Core: \(char.name!)")
        
        saveContext()
        
    }
    
    func deleteFavoriteCharacterFromCore(withChar char: aCharacter) -> Bool{
        
        let savedCharacters = getCoreFavoriteCharacters()
        
        for aChar in savedCharacters{
            let ch = aCharacter(with:aChar)
            if( ch == char)
            {
                deleteCharacterFromCore(withCore: aChar)
                return true
            }
        }
        return false
    }
    
    func deleteCharacter(withChar char: CoreFavoriteCharacter) {
        context.delete(char)
        saveContext()
    }
    
    func getCoreComics() -> [CoreComic]{
        
        //fetch request
        let fetchRequest = NSFetchRequest<CoreComic>(entityName: Constants.Keys.CoreComic.rawValue)
        
        //container
        var CoreComics = [CoreComic]()
        
        do {
            
            CoreComics = try context.fetch(fetchRequest)
            print("CoreComics Count: \(CoreComics.count)")
            return CoreComics
            
        } catch {
            
            return []
        }
    }
    
    func saveComic(withComic comic: Comic) -> Bool{
        
        let savedComics = getCoreComics()
        
        //entity description
        let entity = NSEntityDescription.entity(forEntityName: Constants.Keys.CoreComic.rawValue, in: context)!
        
        //core entity
        let CoreComic = NSManagedObject(entity: entity, insertInto: context)
        
        CoreComic.setValue(comic.id, forKey: Constants.CoreComicKeys.id.rawValue)
        CoreComic.setValue(comic.description, forKey: Constants.CoreComicKeys.descript.rawValue)
        CoreComic.setValue(comic.image, forKey: Constants.CoreComicKeys.image.rawValue)
        CoreComic.setValue(comic.title, forKey: Constants.CoreComicKeys.title.rawValue)
        CoreComic.setValue(comic.creators, forKey: Constants.CoreComicKeys.creators.rawValue)
        CoreComic.setValue(comic.issueNumber, forKey:
            Constants.CoreComicKeys.issueNumber.rawValue)
        CoreComic.setValue(comic.price, forKey: Constants.CoreComicKeys.price.rawValue)
        
        
        //check if exists in core data
        for aComic in savedComics{
            let co = Comic(with: aComic)
            if( co == comic)
            {
                context.delete(aComic)
                print("Comic: \(comic.title) already exists in core data.")
                return false
            }
        }
        
        //save context
        saveContext()
        print("Saved Character To Core: \(comic.title)")
        return true
    }
    
    func deleteComic(with comic: Comic) -> Bool{
        
        let savedComics = getCoreComics()
        
        for aComic in savedComics{
            let co = Comic(with: aComic)
            if( co == comic)
            {
                deleteComic(withCore: aComic)
                return true
            }
        }
        return false
    }
    
    func deleteComic(withCore comic: CoreComic) {
        context.delete(comic)
        saveContext()
    }
    
    func saveContext() {
        
        do {
            try context.save()
        } catch {
            fatalError("Couldn't save the context")
        }
        
    }
}

