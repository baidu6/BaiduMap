//
//  String+Extension.swift
//  BaiduMapDemo
//
//  Created by 王云 on 2018/2/6.
//  Copyright © 2018年 王云. All rights reserved.
//

import Foundation
extension String {
    
    func toInt() -> Int? {
        return Int(self)
    }
    
    func toFloat() -> Float? {
        return Float(self)
    }
    
    func toDouble() -> Double? {
        return Double(self)
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
}
