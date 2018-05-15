//
//  Networking.swift
//  careem-ass
//
//  Created by Huy Nguyễn on 5/8/18.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import Alamofire
import ObjectMapper
import PromiseKit

class Networking {
    
    static let shared = Networking()
    
    func fetchMovieList(with text: String, page: Int) -> Promise<BaseObj<MovieObj>?> {
        let movieObj = FetchMovieList(param: [Constants.APIKey.Query: text, Constants.APIKey.Page: page])
        return movieObj.toPromise()
    }
}
