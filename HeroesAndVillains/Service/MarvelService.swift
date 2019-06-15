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
    
    lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        return URLSession(configuration: config)
    }()
    
    
    
    //MARK: Character
    func getCharacters(completion: @escaping CharacterHandler){
        
        let urlString = MarvelAPI.getCharactersURL()
        
        guard let finalURL = URL(string: urlString) else {
            completion([])
            return
        }
        
        session.dataTask(with: finalURL) { (dat, _, _) in
            
            if let data = dat {
                
                do {
                    let response = try JSONDecoder().decode(CharacterResults.self, from: data)
                    
                    let marvelCharacters = response.data.results
                    
                    completion(marvelCharacters)
                    
                } catch let err {
                    completion([])
                    print("Decoding Error: \(err.localizedDescription)")
                }
                
            }
            
            }.resume()
    }
    
    func getCharacterByFullName(fullName: String, completion: @escaping CharacterHandler){
        
        let urlString = MarvelAPI.getCharacterByFullNameURL(fullName)
        
        guard let finalURL = URL(string: urlString) else {
            completion([])
            return
        }
        
        session.dataTask(with: finalURL) { (dat, _, _) in
            
            if let data = dat {
                
                do {
                    let response = try JSONDecoder().decode(CharacterResults.self, from: data)
                    
                    let marvelCharacter = response.data.results
                    
                    completion(marvelCharacter)
                    
                } catch let err {
                    completion([])
                    print("Decoding Error: \(err.localizedDescription)")
                }
                
            }
            
            }.resume()
    }
    
    func getCharacterByNameStartsWith(fullName: String, completion: @escaping CharacterHandler){
        
        var name = String()
        if fullName.count > 3{
            name = String(fullName.prefix(3))
        }else{
            name = String(fullName.prefix(fullName.count))
        }
        let urlString = MarvelAPI.getCharacterByNameStartsWithURL(name)
        
        guard let finalURL = URL(string: urlString) else {
            completion([])
            return
        }
        
        session.dataTask(with: finalURL) { (dat, _, _) in
            
            if let data = dat {
                
                do {
                    let response = try JSONDecoder().decode(CharacterResults.self, from: data)
                    
                    let marvelCharacter = response.data.results
                    
                    completion(marvelCharacter)
                    
                } catch let err {
                    completion([])
                    print("Decoding Error: \(err.localizedDescription)")
                }
                
            }
            
            }.resume()
    }
    
    //MARK: Comics
    
    func getComics(completion: @escaping ComicHandler){
        
        let urlString = MarvelAPI.getComicsURL()
        
        guard let finalURL = URL(string: urlString) else {
            completion([])
            return
        }
    
    session.dataTask(with: finalURL) { (dat, _, _) in
    
        if let data = dat {
            
            do {
                let response = try JSONDecoder().decode(ComicResults.self, from: data)
                
                let marvelComics = response.data.results
                
                completion(marvelComics)
                
            } catch let err {
                completion([])
                print("Decoding Error: \(err.localizedDescription)")
            }
            
        }
        
        }.resume()
    }
    
    func getComicsForCharacter(for charID: Int, dateDescriptor period: String?, forDate1 date1: String?, forDate2 date2: String?, completion: @escaping ComicHandler){
        
        let urlString = MarvelAPI.getComicsForCharacterURL(for: charID, dateDescriptor: period, fordate1: date1, fordate2: date2)
        
        guard let finalURL = URL(string: urlString) else {
            completion([])
            return
        }
        
        session.dataTask(with: finalURL) { (dat, _, _) in
            
            if let data = dat {
                
                do {
                    let response = try JSONDecoder().decode(ComicResults.self, from: data)
                    
                    let marvelComics = response.data.results
                    
                    completion(marvelComics)
                    
                } catch let err {
                    completion([])
                    print("Decoding Error: \(err.localizedDescription)")
                }
                
            }
            
            }.resume()
    }
    
    func getComicsLatest(dateDescriptor period: String, forDate1 date1: String?, forDate2 date2: String?, completion: @escaping ComicHandler){
        
        let urlString = MarvelAPI.getComicsLatestURL(dateDescriptor: period, fordate1: date1, fordate2: date2)
        
        guard let finalURL = URL(string: urlString) else {
            completion([])
            return
        }
        
        session.dataTask(with: finalURL) { (dat, _, _) in
            
            if let data = dat {
                
                do {
                    let response = try JSONDecoder().decode(ComicResults.self, from: data)
                    
                    let marvelComics = response.data.results
                    
                    completion(marvelComics)
                    
                } catch let err {
                    completion([])
                    print("Decoding Error: \(err.localizedDescription)")
                }
                
            }
            
            }.resume()
    }
}
