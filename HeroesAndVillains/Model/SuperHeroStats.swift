//
//  SuperHeroStats.swift
//  HeroesAndVillains
//
//  Created by Zane on 6/28/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation

struct CharacterStatsResult: Decodable {
    let response, resultsFor: String
    let results: [CharacterStats]
    
    enum CodingKeys: String, CodingKey {
        case response
        case resultsFor = "results-for"
        case results
    }
}

// MARK: - Result
struct CharacterStats: Decodable {
    let id, name: String
    let powerstats: Powerstats
    let biography: Biography
    let appearance: Appearance
    let work: Work
    let connections: Connections
    let image: csImage
}

// MARK: - Appearance
struct Appearance: Decodable {
    let gender, race: String
    let height, weight: [String]
    let eyeColor, hairColor: String
    
    enum CodingKeys: String, CodingKey {
        case gender, race, height, weight
        case eyeColor = "eye-color"
        case hairColor = "hair-color"
    }
}

// MARK: - Biography
struct Biography: Decodable {
    let fullName, alterEgos: String
    let aliases: [String]
    let placeOfBirth, firstAppearance, publisher, alignment: String
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full-name"
        case alterEgos = "alter-egos"
        case aliases
        case placeOfBirth = "place-of-birth"
        case firstAppearance = "first-appearance"
        case publisher, alignment
    }
}

// MARK: - Connections
struct Connections: Decodable {
    let groupAffiliation, relatives: String
    
    enum CodingKeys: String, CodingKey {
        case groupAffiliation = "group-affiliation"
        case relatives
    }
}

// MARK: - Image
struct csImage: Decodable {
    let url: String
}

// MARK: - Powerstats
struct Powerstats: Decodable {
    let intelligence, strength, speed, durability: String
    let power, combat: String
}

// MARK: - Work
struct Work: Decodable {
    let occupation, base: String
}
