//
//  ViewController.swift
//  careem-ass
//
//  Created by Huy Nguyễn on 5/8/18.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SearchTextField

protocol MovieControllerOutput {
    
    func fetchList()
    
    func fetchList(withText text: String)
    
    func loadMore(withText text: String, page: Int)
    
    func searchMovieWithSuggestion(_ text: String)
}

protocol MovieControllerDatasource: class {
    
    func dataSource() -> UITableViewDataSource
    
    func delegate() -> UITableViewDelegate
    
    func suggestionDataSource() -> UITableViewDataSource
    
    func suggestionDelegate() -> UITableViewDelegate
}


class MovieController: UIViewController {
    
    //    MARK:- Delegates
    var output: MovieControllerOutput?
    weak var input: MoviePresenterOutput?
    weak var dataSource: MovieControllerDatasource?

    //    MARK:- IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var suggestTableView: UITableView!
    @IBOutlet weak var suggestView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MovieConfiguration.shared.configue(viewController: self)
        
        self.initBaseAbility()
        
        self.output?.fetchList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func initUIs() {
        
        // Register Movie Table View
        self.tableView.registerCell(MovieCell.self)
        self.tableView.dataSource = self.dataSource?.dataSource()
        self.tableView.delegate = self.dataSource?.delegate()
        self.tableView.keyboardDismissMode = .onDrag
        
        // Register Movie Table View
        self.suggestTableView.registerCell(SuggestionCell.self)
        self.suggestTableView.dataSource = self.dataSource?.suggestionDataSource()
        self.suggestTableView.delegate = self.dataSource?.suggestionDelegate()
    }
}

extension MovieController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.suggestView.isHidden = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.output?.searchMovieWithSuggestion(searchText)
        self.suggestTableView.autoHeight()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.suggestView.isHidden = true
        
        searchBar.resignFirstResponder()
        
        guard let searchText = searchBar.text else { return }
        
        self.output?.fetchList(withText: searchText)
    }
}

extension MovieController: MoviePresenterOutput {
    
    func didSelectRow(_ value: String) {
        
        self.suggestView.isHidden = true
        
        searchBar.resignFirstResponder()
        
        searchBar.text = value
        
        self.output?.fetchList(withText: value)
    }
    
    
    func loadMore(with pageNumber: Int) {
        guard let searchText = searchBar.text else { return }
        self.output?.loadMore(withText: searchText, page: pageNumber)
    }
    
    func presentError(_ error: NSError) { }
    
    func reloadTableView() {
        self.tableView.reloadData()
        self.suggestTableView.reloadData()
    }
}
