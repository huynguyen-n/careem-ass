//
//  MovieConfiguration.swift
//  careem-ass
//
//  Created by Huy Nguyễn on 5/9/18.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import Foundation

class MovieConfiguration {
 
    static let shared = MovieConfiguration()
    
    func configue(viewController: MovieController) {
        let presenter = MoviePresenter()
        presenter.output = viewController
        
        let interactor = MovieInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.dataSource = presenter
    }
}
