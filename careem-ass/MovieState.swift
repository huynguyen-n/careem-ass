//
//  MovieState.swift
//  careem-ass
//
//  Created by Huy Nguyễn on 5/9/18.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import Foundation
import ReSwift
import RxSwift


class MovieState: StateType {
    
    var movies = Variable<BaseObj<MovieObj>?>(nil)
    
    var suggestions = Variable<[String]?>([])
}

extension MovieState {
    static func reducer(action: Action, state: MovieState?) -> MovieState {
        
        // Get state
        let state = state ?? MovieState()
        
        // Doing
        switch action {
        case let action as UpdateMovieListAct:
            
            /// Update here
            state.movies.value = action.movies
            
            break
        case let action as UpdateMoreMovieListAct:
            
            let currStateMovie = state.movies.value
            
            currStateMovie?.setPage(action.movies?.page)
            
            currStateMovie?.setResult(action.movies?.result)
            
            state.movies.value = currStateMovie
            
            break
            
        case let action as UpdateSuggestionMovieAct:
            
            state.suggestions.value = action.suggestion
            
            break
        default:
            break
        }
        
        return state
    }
}
