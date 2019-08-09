//
//  ComicVineService.swift
//  HeroesAndVillains
//
//  Created by Zane on 6/16/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation

typealias CVideoHandler = ([CVideo]) -> Void
typealias ComicVineComicHandler = ([CVComic]) -> Void
let cvService = ComicVineService.shared

final class ComicVineService{
    
    static let shared = ComicVineService()
    
    lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        return URLSession(configuration: config)
    }()
    
    //Mark: Comics
    
    func getComicsWithName(name: String, completion: @escaping ComicVineComicHandler){
        
        let urlString = ComicVineAPI.getComicsWithNameURL(name: name)
        
        let apiCaller = WebAPICaller()
        apiCaller.getCVComicData(urlString: urlString, completion: {[] comics in
            
            completion(comics)
        })
    }
    
    //MARK: Videos
    func getLatestVideos(completion: @escaping CVideoHandler){
        
        let urlString = ComicVineAPI.getVideosURL()
        
        let apiCaller = WebAPICaller()
        apiCaller.getCVVideoData(urlString: urlString, completion: {[] videos in
            
            completion(videos)
        })
    }
}
