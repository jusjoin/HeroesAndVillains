//
//  ComicVineVideo.swift
//  HeroesAndVillains
//
//  Created by Zane on 6/16/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation

struct ComicVineVideoResults: Decodable{
    let results: [CVideo]
}

class CVideo: Decodable{
    let id, lengthSeconds : Int
    let name, publishDate : String
    let premium: Bool
    let image: [String: String?]
    let youtubeID: String?
    let highURL: String
    let lowURL: String?
    let url: String
    
    enum CodingKeys: String, CodingKey{
        case id, name, premium, image, url
        case lengthSeconds = "length_seconds"
        case publishDate = "publish_date"
        case highURL = "high_url"
        case lowURL = "low_url"
        case youtubeID = "youtube_id"
    }
}
