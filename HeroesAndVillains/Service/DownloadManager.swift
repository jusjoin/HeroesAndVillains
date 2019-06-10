//
//  DownloadManager.swift
//  LastMusic
//
//  Created by mac on 5/21/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation


let dlManager = DownloadManager.shared
typealias DataHandler = (Data?) -> Void

final class DownloadManager {
    
    static let shared = DownloadManager()
    private init() {}
    
    lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        return URLSession(configuration: config)
    }()
    
    let cache = NSCache<NSString, NSData>()
    
    func download(_ url: String, completion: @escaping DataHandler) {
        
        if let data = cache.object(forKey: url as NSString) {
            completion(data as Data)
            return
        }
        guard let finalURL = URL(string: url) else {
            completion(nil)
            return
        }
        
        session.dataTask(with: finalURL) { [unowned self] (dat, _, _) in
            
            if let data = dat {
                
                self.cache.setObject(data as NSData, forKey: url as NSString)
                
                DispatchQueue.main.async {
                    completion(data)
                }
            }
        }.resume()
        
    }
    
}
