//
//  Constants.swift
//  careem-ass
//
//  Created by Huy Nguyễn on 5/8/18.
//  Copyright © 2018 Huy Nguyễn. All rights reserved.
//

import Foundation

struct Constants {
    
    struct App {
        
        #if DEBUG
        
        static let BaseAPI = "itunes.apple.com"
        
        #else
        
        static let BaseAPI = ""
        
        #endif
        
        static let isHTTPS: Bool = true
        
        static let BaseURL: String = {
            if Constants.App.isHTTPS {
                return "https://" + BaseAPI
            } else {
                return "http://" + BaseAPI
            }
        }()
    }
    
    struct APIEndpoint {
        
        static let Search = "/search"
    }
    
    struct APIKey {
        
        static let Term = "term"
        
        static let Entity = "entity"
    }
    
    struct ObjModel {
        
        struct Track {
            static let TrackName = "trackName"
            static let PreviewURL = "previewUrl"
        }
    }
}
