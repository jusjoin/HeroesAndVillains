//
//  MarvelServiceTests.swift
//  HeroesAndVillainsTests
//
//  Created by Zane on 8/8/19.
//  Copyright © 2019 Z. All rights reserved.
//

import XCTest
import CoreData
@testable import Comic_Clash

class MarvelServiceTests: XCTestCase{
    
    /*Test should return a json dataset of characters*/
    func test_getCharacters(){
        
        var theCharacters = [marvelCharacter]()
        let exp = expectation(description: "Check if character dataset has been retrieved successfully")
        mvlService.getCharacters(){ [] characters in
            
            theCharacters = characters
            exp.fulfill()
        }
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            XCTAssertGreaterThan(theCharacters.count, 0)
        }
    }
    
    func test_getCharactersByFullName(){
        
        var theCharacters = [marvelCharacter]()
        let exp = expectation(description: "Check if character dataset has been retrieved successfully")
        mvlService.getCharacterByFullName(fullName: "Wolverine"){ [] characters in
            
            theCharacters = characters
            exp.fulfill()
        }
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            XCTAssertEqual(theCharacters.count, 1)
        }
    }
    
    func test_getCharactersByNameStartsWith(){
        
        var theCharacters = [marvelCharacter]()
        let exp = expectation(description: "Check if character dataset has been retrieved successfully")
        mvlService.getCharacterByNameStartsWith(fullName: "wol"){ [] characters in
            
            theCharacters = characters
            exp.fulfill()
        }
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            XCTAssertGreaterThan(theCharacters.count, 1)
        }
    }
    
    func test_getCharactersForComics(){
        
        
    }
}
