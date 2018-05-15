//
//  SuggestionDataSource.swift
//  careem-ass
//
//  Created by Huy Nguyễn on 5/14/18.
//  Copyright © 2018 Huy Nguyễn. All rights reserved.
//

import Foundation
import RxSwift

protocol SuggestionDataSourceDelegate: class {
    
    // Reload
    func reloadTableView()
    
    // Didselect
    func didSelectRow(_ value: String)
}

class SuggestionDataSource: NSObject {
    
    weak var delegate: SuggestionDataSourceDelegate?
    private let disableBag = DisposeBag()
    fileprivate var suggestions: Variable<[String]?>? {
        return mainStore.state.movieState?.suggestions
    }
    
    override init() {
        super.init()
        
        self.suggestions?.asObservable().subscribe{ [unowned self] (query) in
            self.delegate?.reloadTableView()
        }.disposed(by: disableBag)
    }
}

extension SuggestionDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestions?.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestionCell", for: indexPath) as! SuggestionCell
        cell.configureCell(self.suggestions?.value?[indexPath.row])
        return cell
    }
}

extension SuggestionDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let value = self.suggestions?.value?[indexPath.row] else {
            return
        }
        self.delegate?.didSelectRow(value)
    }
}
