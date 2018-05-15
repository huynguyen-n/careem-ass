//
//  MovieObj.swift
//  careem-ass
//
//  Created by Huy Nguyễn on 5/9/18.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import UIKit
import ObjectMapper

class MovieObj: Mappable {
    
    public private(set) var posterURL: String?
    public private(set) var movieName: String?
    public private(set) var releaseDate: Date?
    public private(set) var overview: String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        
        posterURL <- map[Constants.ObjModel.Movie.Poster]
        movieName <- map[Constants.ObjModel.Movie.Name]
        releaseDate <- (map[Constants.ObjModel.Movie.ReleaseDate], CustomDateFormatTransform(formatString: "yyyy-MM-dd"))
        overview <- map[Constants.ObjModel.Movie.Overview]
    }
}
