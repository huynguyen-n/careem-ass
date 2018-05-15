//
//  BaseAbility.swift
//  careem-ass
//
//  Created by Huy Nguyễn on 5/9/18.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import Foundation

protocol BaseAbility: class {
    
    func initBaseAbility()
    
    func initCommons()
    
    func initUIs()
    
    func initBinding()
    
    func initActions()
}

extension BaseAbility {
    
    func initBaseAbility() {
        self.initCommons()
        self.initUIs()
        self.initBinding()
        self.initActions()
    }
}
