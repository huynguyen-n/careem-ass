//
//  UITableView+Register.swift
//  careem-ass
//
//  Created by Huy Nguyễn on 5/9/18.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import Foundation
import UIKit


extension UITableView {
    
    func registerCell<T: Identifier>(_ viewType: T.Type) {
        self.register(viewType.xib(), forCellReuseIdentifier: viewType.identifierView)
    }
    
    func autoHeight() {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            var frame = self.frame
            frame.size.height = self.contentSize.height
            self.frame = frame
        }
    }
}
