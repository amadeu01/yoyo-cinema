//
//  SearchMoviePresenter.swift
//  YoyoFramework
//
//  Created by Amadeu Cavalcante Filho on 02/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation


class SearchMoviePresenter: SearchMoviePresenterProtocol {
    fileprivate var currentPage: Int = 0
    fileprivate var movieQuery: String = ""
    
    var searchInteractor: SearchMovieInteractorInputProtocol?
    
    var view: SearchMovieViewProtocol?
    
    var wireFrame: SearchMovieWireFrameProtocol?
    
    init(view: SearchMovieViewProtocol, searchInteractor: SearchMovieInteractorInputProtocol,
         wireFrame: SearchMovieWireFrameProtocol) {
        self.view = view
        self.searchInteractor = searchInteractor
        self.wireFrame = wireFrame
    }
    
    func viewDidLoad() {
        
    }
    
    func loadMoreMovies() {
        searchInteractor?.searchMovie(by: movieQuery, at: currentPage + 1)
    }
    
    func viewWillAppear() {
        
    }
    
    func searchMovie(matching query: String) {
        movieQuery = query
        searchInteractor?.searchMovie(by: movieQuery, at: currentPage + 1)
    }
}

extension SearchMoviePresenter: SearchMovieInteractorOutputProtocol {
    func onError() {
        
    }
    
    func didRetrieveMovies(_ movies: [MovieEntity], for query: String) {
        if movieQuery == query {
            view?.movieList?.showMovies(movies)
            view?.movieList?.hideLoading()
            currentPage += 1
        }
    }
}
