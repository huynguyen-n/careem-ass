//
//  BaseObj.swift
//  careem-ass
//
//  Created by Huy Nguyễn on 5/15/18.
//  Copyright © 2018 Huy Nguyễn. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseObj<T: Mappable>: Mappable {
    
    public private(set) var page: Int?
    public private(set) var totalResults: Int?
    public private(set) var totalPages: Int?
    public private(set) var result: [T]?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        page <- map[Constants.ObjModel.Page]
        totalResults <- map[Constants.ObjModel.TotalResults]
        totalPages <- map[Constants.ObjModel.TotalPages]
        result <- map[Constants.ObjModel.Results]
    }
    
    func setPage(_ newValue: Int?) {
        self.page = newValue
    }
    
    func setResult(_ newValue: [T]?) {
        guard let newValue = newValue else { return }
        self.result! += newValue
    }
}
