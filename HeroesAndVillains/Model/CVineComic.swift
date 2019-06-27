//
//  ComicVineComic.swift
//  HeroesAndVillains
//
//  Created by Zane on 6/25/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation

class ComicVineComicResults: Decodable{
    let results: [CVComic]
    
}

class CVComic: Decodable{
    let apiDetailURL: String
    let coverDate: String?
    let dateAdded, dateLastUpdated: String
    let description: String?
    let hasStaffReview: Bool
    let id: Int
    let image: Image
    let issueNumber, name: String
    let siteDetailURL: String
    let storeDate: String?
    let volume: CVolume
    //let deck:
    
    enum CodingKeys: String, CodingKey {
        case apiDetailURL = "api_detail_url"
        case coverDate = "cover_date"
        case dateAdded = "date_added"
        case dateLastUpdated = "date_last_updated"
        //case deck
        case description
        case hasStaffReview = "has_staff_review"
        case id, image
        case issueNumber = "issue_number"
        case name
        case siteDetailURL = "site_detail_url"
        case storeDate = "store_date"
        case volume
    }
}


class CVolume: Decodable {
    let apiDetailURL: String
    let id: Int
    let name: String
    let siteDetailURL: String
    
    enum CodingKeys: String, CodingKey {
        case apiDetailURL = "api_detail_url"
        case id, name
        case siteDetailURL = "site_detail_url"
    }
}

struct Volume: Decodable {
    let apiDetailURL: String
    let id: Int
    let name: String
    let siteDetailURL: String
    
    enum CodingKeys: String, CodingKey {
        case apiDetailURL = "api_detail_url"
        case id, name
        case siteDetailURL = "site_detail_url"
    }
}

struct Image: Decodable {
    let iconURL, mediumURL, screenURL, screenLargeURL: String
    let smallURL, superURL, thumbURL, tinyURL: String
    let originalURL: String
    let imageTags: String
    
    enum CodingKeys: String, CodingKey {
        case iconURL = "icon_url"
        case mediumURL = "medium_url"
        case screenURL = "screen_url"
        case screenLargeURL = "screen_large_url"
        case smallURL = "small_url"
        case superURL = "super_url"
        case thumbURL = "thumb_url"
        case tinyURL = "tiny_url"
        case originalURL = "original_url"
        case imageTags = "image_tags"
    }
}


