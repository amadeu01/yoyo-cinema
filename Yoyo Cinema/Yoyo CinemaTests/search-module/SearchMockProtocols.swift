//
//  MockProtocols.swift
//  Yoyo CinemaTests
//
//  Created by Amadeu Cavalcante Filho on 04/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation
@testable import Yoyo_Cinema


final class MockedSearchMovieViewProtocol: SearchMovieViewProtocol {
    var movieListAccessed = false
    var presenterAccessed = false
    var injectedPresenter: SearchMoviePresenterProtocol? = nil
    var presenterNewValue: SearchMoviePresenterProtocol? = nil
    var injectedMovieList: MovieListViewProtocol? = nil
    var movieListNewValue: MovieListViewProtocol? = nil
    
    var presenter: SearchMoviePresenterProtocol? {
        get {
            self.presenterAccessed = true
            return injectedPresenter
        }
        
        set {
            presenterNewValue = newValue
        }
    }
    
    var movieList: MovieListViewProtocol? {
        get {
            movieListAccessed = true
            return injectedMovieList
        }
        
        set {
            movieListNewValue = newValue
        }
    }
    
}

final class MockedSearchMoviePresenter: SearchMoviePresenterProtocol {
    var view: SearchMovieViewProtocol?
    
    var searchInteractor: SearchMovieInteractorInputProtocol?
    
    var wireFrame: SearchMovieWireFrameProtocol?
    
    var viewDidLoadInvoked = false
    var viewWillAppearInvoked = false
    var searchMovieInvoked = false
    var loadMoreMoviesInvoked = false
    
    func viewDidLoad() {
        viewDidLoadInvoked = true
    }
    
    func viewWillAppear() {
        viewWillAppearInvoked = true
    }
    
    func searchMovie(matching query: String) {
        searchMovieInvoked = true
    }
    
    func loadMoreMovies() {
        loadMoreMoviesInvoked = true
    }
}

final class MockSearchMovieInteractorOutput: SearchMovieInteractorOutputProtocol {
    var onErrorInvoked = false
    var didRetrieveMoviesInvoked = false
    var didRetrieveMoviesResponse: [MovieEntity]? = nil
    var didRetrieveMoviesQueryResponse: String? = nil
    
    func onError() {
        onErrorInvoked = true
    }
    
    func didRetrieveMovies(_ movies: [MovieEntity], for query: String) {
        didRetrieveMoviesInvoked = true
        didRetrieveMoviesResponse = movies
        didRetrieveMoviesQueryResponse = query
    }
}
