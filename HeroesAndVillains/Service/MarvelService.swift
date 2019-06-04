//
//  MarvelService.swift
//  HeroesAndVillains
//
//  Created by Admin on 6/4/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation

typealias CharacterHandler = ([Result]) -> Void
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
        
        let urlString = MarvelAPI.getCharacters()
        
        guard let finalURL = URL(string: urlString) else {
            completion([])
            return
        }
        
        session.dataTask(with: finalURL) { (dat, _, _) in
            
            if let data = dat {
                
                do {
                    let response = try JSONDecoder().decode(CharacterResults.self, from: data)
                    
                    let marvelCharacters = response.data.results.character
                    
                    completion(marvelCharacters)
                    
                } catch let err {
                    completion([])
                    print("Decoding Error: \(err.localizedDescription)")
                }
                
            }
            
            }.resume()
    }
    
}
