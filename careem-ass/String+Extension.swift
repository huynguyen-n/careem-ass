//
//  String.swift
//  careem-ass
//
//  Created by Huy Nguyễn on 5/14/18.
//  Copyright © 2018 Huy Nguyễn. All rights reserved.
//

import Foundation

enum PosterSize: String {
    
    case w92, w185, w500, w780
    
    func toString() -> String { return self.rawValue + "/" }
}

extension String {
    
    func getPosterUrl(with size: PosterSize) -> String {
        return Constants.App.BaseImageURL + size.toString() + self
    }
}
