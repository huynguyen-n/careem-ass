//
//  MainWorker.swift
//  careem-ass
//
//  Created by Huy Nguyễn on 5/9/18.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import Foundation
import PromiseKit

protocol MainWorker {
    
}

protocol AsyncWorker: MainWorker {
    
    associatedtype T
    
    func excute() -> Promise<T>
}

protocol SyncWorker: MainWorker {
    func excute()
}
