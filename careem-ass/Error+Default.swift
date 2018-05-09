//
//  Error+Default.swift
//  careem-ass
//
//  Created by Huy Nguyễn on 5/8/18.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import Foundation

extension NSError {
    
    /// Unknow error
    static func unknowError() -> NSError {
        let userInfo = [NSLocalizedDescriptionKey: "Unknow error"]
        return NSError(domain: "com.apple.defaultError", code: 999, userInfo: userInfo)
    }
    
    
    /// JSON Mapper Error
    static func jsonMapperError() -> NSError {
        let userInfo = [NSLocalizedDescriptionKey: "JSON Mapper error"]
        return NSError(domain: "com.apple.defaultError", code: 998, userInfo: userInfo)
    }
}
