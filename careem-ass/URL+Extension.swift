//
//  URL+Extension.swift
//  careem-ass
//
//  Created by Huy Nguyễn on 5/14/18.
//  Copyright © 2018 Huy Nguyễn. All rights reserved.
//

import Foundation

extension Optional where Wrapped == URL {
    
    func addApiKey() -> URL? {
        guard let strUrl = self?.absoluteString else { return self }
        let queryItems = [URLQueryItem(name: Constants.APIKey.APIKey, value: Constants.App.MainKey)]
        let urlComps = NSURLComponents(string: strUrl)
        urlComps?.queryItems = queryItems
        return urlComps?.url
    }
}
