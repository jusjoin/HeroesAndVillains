//
//  FavoritesDataTests.swift
//  HeroesAndVillainsTests
//
//  Created by Zane on 8/8/19.
//  Copyright © 2019 Z. All rights reserved.
//

import XCTest
import CoreData
@testable import Comic_Clash

class FavoritesDataTests: XCTestCase{
    
    //var coreManager: CoreManager!
    
    override func setUp() {
        super.setUp()
        //coreManager = CoreManager.sharedInstance
    }
    
    override func tearDown() {

        super.tearDown()
    }
    
    func testPerformanceExample() {
        
        self.measure {
            
        }
    }
    
    //MARK: Test Cases
    
    //Test CoreManager initialization
    func test_init_coreDataManager(){
        
        let instance = coreManager//CoreManager.sharedInstance

        XCTAssertNotNil( instance )
    }
    
    //test if NSPersistentContainer (core data stack) initialization
    func test_coreDataStackInitialization() {
        let coreDataStack = coreManager.persistentContainer
        
        XCTAssertNotNil( coreDataStack )
    }
    
    /*Test favorite record insertion*/
    func test_create_favorite_character() {
        
        let batman = aCharacter(id: 1, name: "Batman", description: "The Dark Knight", image: "mask", alignment: "Good")
        
        let superman = aCharacter(id: 2, name: "Superman", description: "The Illegal Alien", image: "mask", alignment: "Good")
        
        let spiderman = aCharacter(id: 3, name: "Spider-Man", description: "The Webbed Warrior", image: "mask", alignment: "Good")

        XCTAssertNotNil( batman )
        
        XCTAssertNotNil( superman )
    
        XCTAssertNotNil( spiderman )
        
    }
    
    /*Test favorite record retrieval*/
    func test_fetch_all_favoriteCharacters() {
        
        //get personRecord already saved
        
        let results = coreManager.getCoreFavoriteCharacters()
        
        //Assert return numbers of items
        //Asserts that two optional values are equal.
        XCTAssertEqual(results.count, 3)
    }
    
    func test_remove_favoriteCharacter() {
        
        /*fetch all items*/
        let favorites = coreManager.getCoreFavoriteCharacters()
        /*get first item*/
        let favorite = favorites[0]
        
        /*total numbers of items*/
        let numberOfFavorites = favorites.count
        
        //remove a item
        coreManager.deleteCharacterFromCore(withCore: favorite)
        
        //Assert number of item - 1. That is after deleting a item, sut.fetchAllPersons()?.count should be equal to numberOfItems!-1.
        XCTAssertEqual(coreManager.getCoreFavoriteCharacters().count, numberOfFavorites-1)
    }
    
    /*test if all favorites are deleted from store*/
    func test_flushFavoriteCharacterData() {
        coreManager.flushFavoriteCharactersData()
        
        /*this test case passes if getCoreFavoriteCharacters returns 0 objects*/ XCTAssertEqual(coreManager.getCoreFavoriteCharacters().count, 0)
    }
}
