//
//  MovieDataSource.swift
//  careem-ass
//
//  Created by Huy Nguyễn on 5/9/18.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

protocol MovieDataSourceDelegate: class {
    
    func loadMore(with pageNumber: Int)
    
    // Reload
    func reloadTableView()
}

class MovieDataSource: NSObject {
    
    weak var delegate: MovieDataSourceDelegate?
    private let disableBag = DisposeBag()
    fileprivate var movies: Variable<BaseObj<MovieObj>?> {
        return mainStore.state.movieState!.movies
    }
    private var pageNumber = 1
    
    override init() {
        super.init()
        
        self.movies.asObservable().subscribe{ [unowned self] (repo) in
            self.delegate?.reloadTableView()
        }.disposed(by: disableBag)
    }
}

extension MovieDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.value?.result?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let results = movies.value?.result, let totalPages = movies.value?.totalPages else {
            return
        }
        if indexPath.row == results.count - 1 && pageNumber < totalPages {
            pageNumber += 1
            delegate?.loadMore(with: pageNumber)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let results = self.movies.value?.result else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.configCell(movie: results[indexPath.row])
        return cell
    }
}

extension MovieDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
