//
//  Set+Extension.swift
//  careem-ass
//
//  Created by Huy Nguyễn on 5/14/18.
//  Copyright © 2018 Huy Nguyễn. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    func setForKey(_ defaultName: String) -> NSSet? {
        guard let array = self.array(forKey: defaultName) else {
            return nil
        }
        return NSSet(array: array)
    }
    
    func setSet(value: NSSet?, forKey defaultName: String) {
        
        guard let value = value else { return }
        
        self.setValue(value.allObjects, forKey: defaultName)
    }
}
