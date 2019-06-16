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
    var alignment = String()
    
    init(){

    }
    
    init(with aChar: marvelCharacter){
        
        id = aChar.id
        name = aChar.name
        description = aChar.description
        image = aChar.thumbnail.path + "." + aChar.thumbnail.extens
        //alignment = aChar.alignment
    }
    
    init(with core: CoreCharacter){
        
        self.id = Int(core.id)
        self.name = core.name!
        self.description = core.descript!
        self.image = core.image!
        
    }
}

extension aCharacter:Equatable{
    static func == (lhs: aCharacter, rhs: aCharacter) -> Bool {
        if(lhs.id == rhs.id){
            return true
        }
        else{
            return false
        }
    }
}
