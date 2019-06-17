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
    var price = String()
    var image = String()
    var creators = String()
    var urls = [Urls]()
    
    init(){
        
    }
    
    init(with aComic: marvelComic){
        
        id = aComic.id
        title = aComic.title
        description = aComic.description ?? "Description unavailable."
        image = Constants.Keys.defaultComicImage.rawValue
        if aComic.images!.isEmpty{print("No image present for comic \(title)")}
        if !aComic.images!.isEmpty{
            guard let path = aComic.images?[0].path else{return}
            guard let ext = aComic.images?[0].extens else{return}
            image = path + "." + ext
        }
        if !aComic.prices.isEmpty{
            price = /*aComic.prices[0].type*/ "Price" + ": " + String(aComic.prices[0].price)
        }
        urls = aComic.urls
        guard let c = aComic.creators else {return}
        guard let ci = c.items else {return}
        if !ci.isEmpty{
//            for items in c.items!{
//                creators += items.name + "; "
//            }
            creators = ci[0].name
        }
    }
    
}
