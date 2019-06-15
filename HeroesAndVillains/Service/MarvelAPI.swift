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
    static let limit = 20
    static let offset = 0
    static let ts = String(Int(Date().timeIntervalSince1970))
    static let publicKey = "ec1082c0a7d0c82057b98aab4e1a4a18"
    static let privateKey = "7eab78cecd6feda9c1948cf74af6a474cc021c50"
    static let hash = "&hash=" + (ts+privateKey+publicKey).md5
    
    
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
        
        print("Search Character URL: " + base + characterNameStartsWithMethod + name + "&ts=" + ts + "&apikey=" + publicKey + hash )
        
        return base + characterFullNameMethod + name + "&ts=" + ts + "&apikey=" + publicKey + hash
        
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
        
        if periodSpecifiers != ""{
            url = (base + comicsMethod + periodSpecifiers +  "&" + comicsForCharacterMethod + charIDString + "&ts=" + ts + "&apikey=" + publicKey + hash )
        }else{
            url = (base + comicsMethod + comicsForCharacterMethod + charIDString + "&ts=" + ts + "&apikey=" + publicKey + hash )
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
