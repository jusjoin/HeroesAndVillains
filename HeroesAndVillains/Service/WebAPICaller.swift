//
//  WebAPICaller.swift
//  HeroesAndVillains
//
//  Created by Zane on 8/5/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation

class WebAPICaller{
    
    lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        return URLSession(configuration: config)
    }()
    
    func getMarvelCharacterData(urlString: String, completion: @escaping CharacterHandler){
        
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
    
    func getMarvelComicData(urlString: String, completion: @escaping ComicHandler){
        
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
    
    func getCVComicData(urlString: String, completion: @escaping ComicVineComicHandler){
        
        guard let finalURL = URL(string: urlString) else {
            completion([])
            return
        }
        
        session.dataTask(with: finalURL) { (dat, _, _) in
            
            if let data = dat {
                
                do {
                    let response = try JSONDecoder().decode(ComicVineComicResults.self, from: data)
                    
                    let comics = response.results
                    
                    completion(comics)
                    
                } catch let err {
                    completion([])
                    print("Decoding Error: \(err.localizedDescription)")
                }
                
            }
            
            }.resume()
    }
    
    func getCVVideoData(urlString: String, completion: @escaping CVideoHandler){
        
        guard let finalURL = URL(string: urlString) else {
            completion([])
            return
        }
        
        session.dataTask(with: finalURL) { (dat, _, _) in
            
            if let data = dat {
                
                do {
                    let response = try JSONDecoder().decode(ComicVineVideoResults.self, from: data)
                    
                    let videos = response.results
                    
                    completion(videos)
                    
                } catch let err {
                    completion([])
                    print("Decoding Error: \(err.localizedDescription)")
                }
                
            }
            
            }.resume()
    }
    
    func getCharacterStatsData(urlString: String, completion: @escaping CStatsHandler){
        
        guard let finalURL = URL(string: urlString) else {
            completion([])
            return
        }
        
        session.dataTask(with: finalURL) { (dat, _, _) in
            
            if let data = dat {
                
                do {
                    let response = try JSONDecoder().decode(CharacterStatsResult.self, from: data)
                    
                    let characterStats = response.results
                    
                    completion(characterStats)
                    
                } catch let err {
                    completion([])
                    print("Decoding Error: \(err.localizedDescription)")
                }
                
            }
            
            }.resume()
    }
}
