//
//  FetchMovieList.swift
//  careem-ass
//
//  Created by Huy Nguyễn on 5/8/18.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import Alamofire
import ObjectMapper

struct FetchMovieList: Requestable {
    
    typealias T = BaseObj<MovieObj>?
    
    var param: Parameters?
    
    var httpMethod: HTTPMethod { get { return .get } }
    
    var endPoint: String { get { return Constants.APIEndpoint.Search + Constants.APIEndpoint.Movie } }
    
    var parameterEncoding: ParameterEncoding { get { return URLEncoding.default } }
    
    func decode(data: Any) -> BaseObj<MovieObj>? {
        let arr = data as? [String: Any]
        return Mapper<BaseObj<MovieObj>>().map(JSON: arr ?? [:])
    }
    
    init(param: Requestable.Parameters?) {
        self.param = param
    }
}
