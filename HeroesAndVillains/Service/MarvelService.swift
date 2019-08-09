//
//  MarvelService.swift
//  HeroesAndVillains
//
//  Created by Admin on 6/4/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation

typealias CharacterHandler = ([marvelCharacter]) -> Void
typealias ComicHandler = ([marvelComic]) -> Void
let mvlService = MarvelService.shared

final class MarvelService{
    
    static let shared = MarvelService()
    //private init() {}
    
//    lazy var session: URLSession = {
//        let config = URLSessionConfiguration.default
//        config.timeoutIntervalForRequest = 30
//        return URLSession(configuration: config)
//    }()
    
    
    
    //MARK: Character
    func getCharacters(completion: @escaping CharacterHandler){
        
        let urlString = MarvelAPI.getCharactersURL()
        
        let apiCaller = WebAPICaller()
        apiCaller.getMarvelCharacterData(urlString: urlString, completion: {[] characters in
            
            completion(characters)
        })
    }
    
    func getCharacterByFullName(fullName: String, completion: @escaping CharacterHandler){
        
        let urlString = MarvelAPI.getCharacterByFullNameURL(fullName)
        
        let apiCaller = WebAPICaller()
        apiCaller.getMarvelCharacterData(urlString: urlString, completion: {[] characters in
            
            completion(characters)
        })
    }
    
    func getCharacterByNameStartsWith(fullName: String, completion: @escaping CharacterHandler){
        
        var name = String()
        if fullName.count > 3{
            name = String(fullName.prefix(3))
        }else{
            name = String(fullName.prefix(fullName.count))
        }
        let urlString = MarvelAPI.getCharacterByNameStartsWithURL(name)
        
        let apiCaller = WebAPICaller()
        apiCaller.getMarvelCharacterData(urlString: urlString, completion: {[] characters in
            
            completion(characters)
        })
    }
    
    func getCharactersForComic(for comicID: Int, completion: @escaping CharacterHandler){
        
        let urlString = MarvelAPI.getCharactersForComicURL(for: comicID)
        
        let apiCaller = WebAPICaller()
        apiCaller.getMarvelCharacterData(urlString: urlString, completion: {[] characters in
            
            completion(characters)
        })
    }
    
    //MARK: Comics
    
    func getComics(completion: @escaping ComicHandler){
        
        let urlString = MarvelAPI.getComicsURL()
        
        let apiCaller = WebAPICaller()
        apiCaller.getMarvelComicData(urlString: urlString, completion: {[] comics in
            
            completion(comics)
        })
    }
    
    func getComicsForCharacter(for charID: Int, dateDescriptor period: String?, forDate1 date1: String?, forDate2 date2: String?, completion: @escaping ComicHandler){
        
        let urlString = MarvelAPI.getComicsForCharacterURL(for: charID, dateDescriptor: period, fordate1: date1, fordate2: date2)
        
        let apiCaller = WebAPICaller()
        apiCaller.getMarvelComicData(urlString: urlString, completion: {[] comics in
            
            completion(comics)
        })
    }
    
    func getComicsLatest(dateDescriptor period: String, forDate1 date1: String?, forDate2 date2: String?, completion: @escaping ComicHandler){
        
        let urlString = MarvelAPI.getComicsLatestURL(dateDescriptor: period, fordate1: date1, fordate2: date2)
        
        let apiCaller = WebAPICaller()
        apiCaller.getMarvelComicData(urlString: urlString, completion: {[] comics in
            
            completion(comics)
        })
    }
}
