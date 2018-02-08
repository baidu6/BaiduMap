//
//  Dictionary+Extension.swift
//  BaiduMapDemo
//
//  Created by 王云 on 2018/2/6.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
extension Dictionary {
    
    func valueForKey<T>(_ key: String) -> T? {
        return self[key as! Key] as? T
    }
    
    func arrayForKey(_ key: String) -> Array<Any>? {
        let value = self[key as! Key]
        return value as? Array<Any>
    }
    
    func dictionaryForKey(_ key: String) -> Dictionary<String, Any>? {
        let value = self[key as! Key]
        return value as? Dictionary<String, Any>
    }
    
    func arrayDictionaryForKey(_ key: String) -> Array<Dictionary<String, Any>>? {
        let value = self[key as! Key]
        return value as? Array<Dictionary<String, Any>>
    }
    
    func stringForKey(_ key: String) -> String? {
        let value = self[key as! Key]
        if value == nil {
            return nil
        }
        return (value! as? String)?.trim() ?? String(describing: value!).trim()
    }
    
    func stringForKey(_ key: String, defaultValue: String) -> String {
        return stringForKey(key) ?? defaultValue
    }
    
    func stringForKeyOrZero(_ key: String) -> String {
        return stringForKey(key, defaultValue: "0")
    }
    
    func stringForKeyOrNull(_ key: String) -> String {
        return stringForKey(key, defaultValue: "--")
    }
    
    func numberForKey(_ key: String) -> NSNumber? {
        let value = self[key as! Key]
        return value as? NSNumber
    }
    
    func intForKey(_ key: String) -> Int? {
        let number = numberForKey(key)
        if number != nil {
            return number?.intValue
        }else if let str = stringForKey(key){
            return NSString(string: str).integerValue
        }
        return nil
    }
    
    func intForKey(_ key: String, defaultValue: Int) -> Int {
        return intForKey(key) ?? defaultValue
    }
    
    func intForKeyOrZero(_ key: String) -> Int {
        return intForKey(key, defaultValue: 0)
    }
    
    func floatForKey(_ key: String) -> Float? {
        let number = numberForKey(key)
        if(number != nil){
            return number?.floatValue
        }else if let str = stringForKey(key){
            return NSString(string: str).floatValue
        }
        return nil
    }
    
    func floatForKey(_ key: String, defaultValue: Float) -> Float {
        return floatForKey(key) ?? defaultValue
    }
    
    func floatForKeyOrZero(_ key: String) -> Float {
        return floatForKey(key, defaultValue: 0)
    }
    
    func doubleForKey(_ key: String) -> Double? {
        let number = numberForKey(key)
        if(number != nil){
            return number?.doubleValue
        }else if let str = stringForKey(key){
            return NSString(string: str).doubleValue
        }
        return nil
    }
    
    func doubleForKey(_ key: String, defaultValue: Double) -> Double {
        return doubleForKey(key) ?? defaultValue
    }
    
    func doubleForKeyOrZero(_ key: String) -> Double {
        return doubleForKey(key, defaultValue: 0)
    }
    
    func boolForKey(_ key: String) -> Bool? {
        let number = numberForKey(key)
        if(number != nil){
            return number?.boolValue
        }
        return nil
    }
}

