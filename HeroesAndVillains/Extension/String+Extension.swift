//
//  String+Extension.swift
//  HeroesAndVillains
//
//  Created by Admin on 6/4/19.
//  Copyright © 2019 Z. All rights reserved.
// 

import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

let htmlReplaceString: String  =   "<[^>]+>"

extension String{

    var md5: String{
        
        let md5Data = MD5(string: self)
        return md5Data.map { String(format: "%02hhx", $0) }.joined()
    }
    
    private func MD5(string: String) -> Data {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: length)
        
        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData
    }
    
    func stringByAddingPercentEncodingForRFC3986() -> String? {
        let unreserved = "-._~/?"
        let allowed = NSMutableCharacterSet.alphanumeric()
        allowed.addCharacters(in: unreserved)
        return addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
    }
    
}

extension String {
    /**
     Takes the current String struct and strips out HTML using regular expression. All tags get stripped out.
     
     :returns: String html text as plain text
     */
    
    func stripHTML() -> String {
        return self.replacingOccurrences(of: htmlReplaceString, with: "", options: NSString.CompareOptions.regularExpression, range: nil)
    }
}
