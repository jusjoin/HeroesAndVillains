//
//  MarvelAPI.swift
//  HeroesAndVillains
//
//  Created by Admin on 6/4/19.
//  Copyright © 2019 Z. All rights reserved.
//

import Foundation

struct MarvelAPI {
    
    static let base = "https://gateway.marvel.com:443/v1/public/"
    static let charactersMethod = "characters?"
    static let characterFullNameMethod = "characters?name="
    static let characterNameStartsWithMethod = "characters?nameStartsWith="
    static let comicsMethod = "comics?"
    static let comicsForCharacterMethod = "characters="
    static let comicsBetweenDatesMethod = "dateRange="
    static let comicsLatestMethod = "dateDescriptor="
    static let seriesMethod = ""
    static let eventsMethod = ""
    static let limit = "50"
    static let offset = 0
    static let ts = String(Int(Date().timeIntervalSince1970))
    static let publicKey = "2f2e2c7ca638152ab1e5654743680a42" //"ec1082c0a7d0c82057b98aab4e1a4a18"
    static let privateKey = "5f113a103171e48d8e8afd99fde752df10c07757"//"7eab78cecd6feda9c1948cf74af6a474cc021c50"
    static let hash = "&hash=" + (ts+privateKey+publicKey).md5 + "&limit=" + limit
    static let hashNoLimit = "&hash=" + (ts+privateKey+publicKey).md5
    
    
    //MARK: Characters
    static func getCharactersURL() -> String{
        
        let url = (base + charactersMethod + "&ts=" + ts + "&apikey=" + publicKey + hash )
        print("Get Characters URL: " + url)
        return url
    }
    
    static func getCharacterByFullNameURL(_ fullName: String) -> String{
        
        let escFullName = fullName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let url = (base + characterFullNameMethod + escFullName + "&ts=" + ts + "&apikey=" + publicKey + hash )
        print("Search Character URL: " + url)
        return url
    }
    
    static func getCharacterByNameStartsWithURL(_ name: String) -> String{
        
        //print("Search Character URL: " + base + characterNameStartsWithMethod + name + "&ts=" + ts + "&apikey=" + publicKey + hash )
        //print("Static string    URL: https://gateway.marvel.com:443/v1/public/characters?nameStartsWith=Spi&ts=1560753917&apikey=ec1082c0a7d0c82057b98aab4e1a4a18&hash=209bdd30118add179ba0d9fcea9ddfd5&limit=50")
        print("Search character URL: https://gateway.marvel.com:443/v1/public/characters?nameStartsWith=" + name + "&ts=" + ts + "&apikey=" + publicKey + hash)
        
        
        return "https://gateway.marvel.com:443/v1/public/characters?nameStartsWith=" + name + "&ts=" + ts + "&apikey=" + publicKey + hash //"&ts=1560753917&apikey=ec1082c0a7d0c82057b98aab4e1a4a18&hash=209bdd30118add179ba0d9fcea9ddfd5&limit=50"//base + characterFullNameMethod + name + "&ts=" + ts + "&apikey=" + publicKey + hash
        
    }
    
    static func getCharactersForComicURL(for comicID: Int) -> String{
        
        let stringID = String(comicID)
        let url = (base + "comics/" + stringID + "/" + charactersMethod + "ts=" + ts + "&apikey=" + publicKey + hash )
        print("Get Comics URL: " + url)
        return url
    }
    
    //MARK: Comics
    
    static func getComicsURL() -> String{
        
        let url = (base + comicsMethod + "ts=" + ts + "&apikey=" + publicKey + hash )
        print("Get Comics URL: " + url)
        return url
    }
    
    static func getComicsForCharacterURL(for charID: Int, dateDescriptor period: String?, fordate1 date1: String?, fordate2 date2: String?) -> String{
        
        //descriptors = thisMonth, thisWeek, nextWeek, lastWeek
        let charIDString = String(charID)
        var url = String()
        var periodSpecifiers = ""
        
        if let thisPeriod = period{
            periodSpecifiers += comicsLatestMethod + thisPeriod
        }
        
        if let thisDate1 = date1{
            if let thisDate2 = date2{
                if periodSpecifiers != ""{
                    periodSpecifiers += "&" + comicsBetweenDatesMethod + thisDate1 + "," + thisDate2
                }else{
                    periodSpecifiers += comicsBetweenDatesMethod + thisDate1 + "," + thisDate2
                }
            }
        }
        //Mark: Bugfix spider-man comic search fails with limit
        var hashToUse = String()
        if charIDString == "1009610"{
            hashToUse = hashNoLimit
        }
        else{
            hashToUse = hash
        }
        if periodSpecifiers != ""{
            url = (base + comicsMethod + periodSpecifiers +  "&" + comicsForCharacterMethod + charIDString + "&ts=" + ts + "&apikey=" + publicKey + hashToUse )
        }else{
            url = (base + comicsMethod + comicsForCharacterMethod + charIDString + "&ts=" + ts + "&apikey=" + publicKey + hashToUse )
        }
        print("Get Comics URL: " + url)
        return url
    }
    
    static func getComicsBetwenDatesURL(fordate1 date1: String, fordate2 date2: String) -> String{
        
        let url = (base + comicsMethod + comicsBetweenDatesMethod + date1 + "," + date2 + "&ts=" + ts + "&apikey=" + publicKey + hash )
        print("Get Comics URL: " + url)
        return url
    }
    
    static func getComicsLatestURL(dateDescriptor period: String?, fordate1 date1: String?, fordate2 date2: String?) -> String{
        
        //descriptors = thisMonth, thisWeek, nextWeek, lastWeek
        
        var url = String()
        var periodSpecifiers = ""
        
        if let thisPeriod = period{
            periodSpecifiers += comicsLatestMethod + thisPeriod
        }
        
        if let thisDate1 = date1{
            if let thisDate2 = date2{
                if periodSpecifiers != ""{
                    periodSpecifiers += "&" + comicsBetweenDatesMethod + thisDate1 + "," + thisDate2
                }else{
                    periodSpecifiers += comicsBetweenDatesMethod + thisDate1 + "," + thisDate2
                }
            }
        }
        
        if periodSpecifiers != ""{
            url = (base + comicsMethod + periodSpecifiers + "&ts=" + ts + "&apikey=" + publicKey + hash )
        }else{
            url = (base + comicsMethod + "ts=" + ts + "&apikey=" + publicKey + hash )
        }
        
        //let url = (base + comicsMethod + comicsLatestMethod + period + "&" + comicsBetweenDatesMethod + date1 + "," + date2 + "ts=" + ts + "&apikey=" + publicKey + hash )
        print("Get Comics URL: " + url)
        
        return url
    }
}
