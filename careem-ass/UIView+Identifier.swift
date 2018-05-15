//
//  UIView+Identifier.swift
//  careem-ass
//
//  Created by Huy Nguyễn on 5/9/18.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import UIKit

extension UIView: Identifier {
    
    
    /// ID View
    static var identifierView: String {
        get {
            return String(describing: self)
        }
    }
    
    
    /// XIB
    static func xib() -> UINib? {
        return UINib(nibName: self.identifierView, bundle: nil)
    }
}
