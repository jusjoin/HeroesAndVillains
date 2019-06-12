//
//  Comic.swift
//  HeroesAndVillains
//
//  Created by Admin on 6/10/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation

class Comic{
    
    var id = Int()
    var title = String()
    var issueNumber = Int()
    var description = String()
    var upc = String()
    var price = Double()
    var image = String()
    var creators = [String]()
    
    init(with aComic: marvelComic){
        
        id = aComic.id
        title = aComic.title
        description = aComic.description ?? ""
        image = Constants.Keys.defaultComicImage.rawValue
        if aComic.images!.isEmpty{print("No image present for comic \(title)")}
        if !aComic.images!.isEmpty{
            guard let path = aComic.images?[0].path else{return}
            guard let ext = aComic.images?[0].extens else{return}
            image = path + "." + ext
        }
        
        
    }
    
}
