//
//  ComicVineService.swift
//  HeroesAndVillains
//
//  Created by Zane on 6/16/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation

typealias CVideoHandler = ([CVideo]) -> Void
let cvService = ComicVineService.shared

final class ComicVineService{
    
    static let shared = ComicVineService()
    
    lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        return URLSession(configuration: config)
    }()
    
    
    //MARK: Videos
    func getLatestVideos(completion: @escaping CVideoHandler){
        
        let urlString = ComicVineAPI.getVideosURL()
        
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
}
