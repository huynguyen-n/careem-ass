//
//  FetchMovieWorker.swift
//  careem-ass
//
//  Created by Huy Nguyễn on 5/9/18.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import UIKit
import PromiseKit
import ReSwift
import RxSwift

struct UpdateMovieListAct: Action {
    var movies: BaseObj<MovieObj>?
}

struct UpdateMoreMovieListAct: Action {
    var movies: BaseObj<MovieObj>?
}

struct UpdateSuggestionMovieAct: Action {
    var suggestion: [String]?
}

class FetchMovieWorker: AsyncWorker {
    
    //    MARK:- Variables
    private var currSearchText: String = ""
    private var suggestSet: Set<String>!
    
    //    MARK:- Delegates
    typealias T = BaseObj<MovieObj>?
    
    func excute() -> Promise<T> {
        
        // Initialize Suggestion
        suggestSet = loadSuggestionList()
        let action = UpdateSuggestionMovieAct(suggestion: self.suggestSet.sorted())
        mainStore.dispatch(action)
        
        // TODO: Do another stuffs, nothing for this case
        return Networking.shared.fetchMovieList(with: "", page: 0)
            .then { (movieObjs) -> Promise<T> in
                
                let action = UpdateMovieListAct(movies: movieObjs)
                mainStore.dispatch(action)
                
                return Promise(value: movieObjs)
        }
    }
    
    func searchMovie(withText text: String) -> Promise<T> {
        self.currSearchText = text
        return Networking.shared.fetchMovieList(with: text, page: 1)
            .then { (movieObjs) -> Promise<T> in
                
                let action = UpdateMovieListAct(movies: movieObjs)
                mainStore.dispatch(action)
                
                if (movieObjs?.result?.count ?? 0) > 0 {
                    self.insertSuggestionList()
                }
                
                return Promise(value: movieObjs)
        }
    }
    
    func loadMoreMovie(with text: String, page: Int) -> Promise<T> {
        return Networking.shared.fetchMovieList(with: self.currSearchText, page: page)
            .then { (movieObjs) -> Promise<T> in
                print(page)
                let action = UpdateMoreMovieListAct(movies: movieObjs)
                mainStore.dispatch(action)
                
                return Promise(value: movieObjs)
        }
    }
    
    func searchMovieWithSuggestion(_ text: String) {
        Observable<String>.just(text)
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [unowned self] query in

                let action = UpdateSuggestionMovieAct(suggestion: query.isEmpty ? self.suggestSet.sorted() : self.suggestSet?.filter{ $0.contains(query) })
                mainStore.dispatch(action)

            }).disposed(by: DisposeBag())
    }
    
    func insertSuggestionList() {
        suggestSet.insert(self.currSearchText)
        UserDefaults.standard.setSet(value: suggestSet as NSSet?, forKey: Constants.UserDefaultKeys.Suggestion)
    }
    
    func loadSuggestionList() -> Set<String> {
        guard let suggestions = UserDefaults.standard.array(forKey: Constants.UserDefaultKeys.Suggestion) as? [String] else {
            return Set<String>()
        }
        return Set(suggestions)
    }
}
