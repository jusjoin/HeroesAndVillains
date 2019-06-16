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
    
    func getCoreCharacters() -> [CoreCharacter]{
        
        //fetch request
        let fetchRequest = NSFetchRequest<CoreCharacter>(entityName: Constants.Keys.CoreCharacter.rawValue)
        
        //container
        var coreCharacters = [CoreCharacter]()
        
        do {
            
            coreCharacters = try context.fetch(fetchRequest)
            print("CoreCharacters Count: \(coreCharacters.count)")
            return coreCharacters
            
        } catch {
            
            return []
        }
    }
    
    func saveCharacter(with char: aCharacter) -> Bool?{
        
        let savedCharacters = getCoreCharacters()

        //entity description
        let entity = NSEntityDescription.entity(forEntityName: Constants.Keys.CoreCharacter.rawValue, in: context)!
        
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
    func deleteCharacter(withCore char: CoreCharacter) {
        
        context.delete(char)
        
        print("Deleted From Core: \(char.name!)")
        
        saveContext()
        
    }
    
    func deleteCharacter(withChar char: aCharacter) -> Bool{
        
        let savedCharacters = getCoreCharacters()
        
        for aChar in savedCharacters{
            let ch = aCharacter(with:aChar)
            if( ch == char)
            {
                deleteCharacter(withCore: aChar)
                return true
            }
        }
        return false
    }
    
    func saveContext() {
        
        do {
            try context.save()
        } catch {
            fatalError("Couldn't save the context")
        }
        
    }
}

