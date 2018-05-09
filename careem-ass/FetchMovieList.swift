//
//  FetchMovieList.swift
//  careem-ass
//
//  Created by Huy Nguyễn on 5/8/18.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import Alamofire
import ObjectMapper

struct FetchTrackList: Requestable {
    
    var endPoint: String {
        return ""
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var param: Requestable.Parameters?
    
    func decode(data: Any) -> String {
        return ""
    }
    
    init(param: Requestable.Parameters?) {
        self.param = param
    }
    
    typealias T = String
}
