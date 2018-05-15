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
        
        static let BaseAPI = "api.themoviedb.org/3"
        
        static let BaseImageAPI = "image.tmdb.org/t/p/"
        
        #else
        
        static let BaseAPI = ""
        
        static let BaseImageAPI = ""
        
        #endif
        
        static let isHTTPS: Bool = true
        
        static let BaseURL: String = {
            return Constants.App.isHTTPS ? "https://" + BaseAPI : "http://" + BaseAPI
        }()
        
        static let BaseImageURL: String = {
            return Constants.App.isHTTPS ? "https://" + BaseImageAPI : "http://" + BaseImageAPI
        }()
        
        static let MainKey: String = "2696829a81b1b5827d515ff121700838"
    }
    
    struct APIEndpoint {
        
        static let Search = "/search"
        
        static let Movie = "/movie"
    }

    struct APIKey {
        
        static let APIKey = "api_key"
        
        static let Query = "query"
        
        static let Page = "page"
    }
    
    struct ObjModel {
        
        static let Page = "page"
        static let TotalResults = "total_results"
        static let TotalPages = "total_pages"
        static let Results = "results"
        
        struct Movie {
            static let Poster = "backdrop_path"
            static let Name = "title"
            static let ReleaseDate = "release_date"
            static let Overview = "overview"
        }
    }
    
    struct UserDefaultKeys {
        static let Suggestion = "suggestion"
    }
}
