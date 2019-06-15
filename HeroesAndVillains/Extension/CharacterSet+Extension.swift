//
//  CharacterSet+Extension.swift
//  HeroesAndVillains
//
//  Created by Zane on 6/13/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation

extension CharacterSet{
    
    static func customAllowedURLCharacters() -> CharacterSet{
        var allowedChars = CharacterSet(charactersIn: "-._~/? ")
        allowedChars.formUnion(CharacterSet.alphanumerics)
        
        return allowedChars
    }
}
