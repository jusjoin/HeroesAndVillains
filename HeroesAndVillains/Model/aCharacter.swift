//
//  aCharacter.swift
//  HeroesAndVillains
//
//  Created by Admin on 6/5/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation

class aCharacter{
    
    var id = Int()
    var name = String()
    var description = String()
    var image = String()
    
    init(with aChar: marvelCharacter){
        
        id = aChar.id
        name = aChar.name
        description = aChar.description
        image = aChar.thumbnail.path + "." + aChar.thumbnail.extens
    }
}
