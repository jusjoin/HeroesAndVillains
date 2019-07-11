//
//  BattleCharacter.swift
//  HeroesAndVillains
//
//  Created by Zane on 7/10/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation

class BattleCharacter{
    
    var id = String()
    var name = String()
    var image = String()
    var stats = Dictionary<String, Float>()
    var powerLevel = Float()
    
    init(){}
    
    init(id: String, name: String, image: String, stats: Dictionary<String, Float>){
        
        self.id = id
        self.name = name
        self.image = image
        self.stats = stats
    }
    
    static func powerLevel(_ cs:CharacterStats) -> Float{
        var pl = Float(cs.powerstats.combat) ?? 0.0
        pl += Float(cs.powerstats.durability) ?? 0.0
        pl += Float(cs.powerstats.intelligence) ?? 0.0
        pl += Float(cs.powerstats.power) ?? 0.0
        pl += Float(cs.powerstats.speed) ?? 0.0
        pl += Float(cs.powerstats.strength) ?? 0.0
        
        return pl/6
    }
    
}
