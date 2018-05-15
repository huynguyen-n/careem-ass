//
//  MovieController.swift
//  careem-ass
//
//  Created by Huy Nguyễn on 5/9/18.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import UIKit

protocol MoviePresenterOutput: class {
    
    func presentError(_ error: NSError)
    
    func reloadTableView()
    
    func loadMore(with pageNumber: Int)
    
    func didSelectRow(_ value: String)
}

class MoviePresenter {
    
    fileprivate lazy var movieDataSource: MovieDataSource = {
       
        let movie = MovieDataSource()
        movie.delegate = self
        return movie
    }()
    
    fileprivate lazy var suggestDataSource: SuggestionDataSource = {
        
        let suggestDataSource = SuggestionDataSource()
        suggestDataSource.delegate = self
        return suggestDataSource
    }()
    
    weak var output: MoviePresenterOutput?
}

extension MoviePresenter: MovieInteractorOutput {
    func presenterError(_ error: NSError) {
        self.output?.presentError(error)
    }
}

extension MoviePresenter: MovieControllerDatasource {
    
    func suggestionDataSource() -> UITableViewDataSource {
        return self.suggestDataSource
    }
    
    func suggestionDelegate() -> UITableViewDelegate {
        return self.suggestDataSource
    }
    
    
    func delegate() -> UITableViewDelegate {
        return self.movieDataSource
    }

    func dataSource() -> UITableViewDataSource {
        return self.movieDataSource
    }
}

extension MoviePresenter: MovieDataSourceDelegate, SuggestionDataSourceDelegate {
    
    func didSelectRow(_ value: String) {
        self.output?.didSelectRow(value)
    }
    
    
    func loadMore(with pageNumber: Int) {
        self.output?.loadMore(with: pageNumber)
    }
    
    func reloadTableView() {
        self.output?.reloadTableView()
    }
}
