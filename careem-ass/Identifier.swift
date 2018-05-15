//
//  Identifiers.swift
//  careem-ass
//
//  Created by Huy Nguyễn on 5/9/18.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import Foundation
import UIKit

protocol Identifier {
    
    static var identifierView: String { get }
    
    static func xib() -> UINib?
}
