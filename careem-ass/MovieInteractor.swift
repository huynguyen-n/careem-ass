//
//  MovieController.swift
//  careem-ass
//
//  Created by Huy Nguyễn on 5/9/18.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import UIKit
import PromiseKit

protocol MovieInteractorOutput {
    
    func presenterError(_ error: NSError)
}

class MovieInteractor {
    
    var output: MovieInteractorOutput?

    fileprivate lazy var fetchMovieWorker: FetchMovieWorker = {
       return FetchMovieWorker()
    }()
}

extension MovieInteractor: MovieControllerOutput {
    
    func searchMovieWithSuggestion(_ text: String) {
        self.fetchMovieWorker.searchMovieWithSuggestion(text)
    }
    
    
    func loadMore(withText text: String, page pageNumber: Int) {
        self.fetchMovieWorker.loadMoreMovie(with: text, page: pageNumber)
            .then { _ -> Void in
                
            }.catch { error in
                self.output?.presenterError(error as NSError)
        }
    }
    
    func fetchList(withText text: String) {
        self.fetchMovieWorker.searchMovie(withText: text)
            .then { _ -> Void in
                
            }.catch { error in
                self.output?.presenterError(error as NSError)
        }
    }
    

    func fetchList() {
        self.fetchMovieWorker.excute()
            .then { _ -> Void in

            }.catch { error in
                self.output?.presenterError(error as NSError)
        }
    }
}
