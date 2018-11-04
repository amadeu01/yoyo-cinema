//
//  Protocols.swift
//  Yoyo Cinema
//
//  Created by Amadeu Cavalcante Filho on 02/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation

public protocol MovieListViewProtocol: class {
    var movieListDelegate: MovieListDelegate? { get set }
    
    func showError()
    
    func showLoading()
    
    func hideLoading()
    
    func showMovies(_ movies: [MovieEntity])
}

public protocol MovieListDelegate: class {
    func loadMoreMovies()
}
