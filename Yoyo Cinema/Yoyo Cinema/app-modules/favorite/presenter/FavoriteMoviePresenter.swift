//
//  FavoriteMoviePresenter.swift
//  YoyoFramework
//
//  Created by Amadeu Cavalcante Filho on 03/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation


public final class FavoriteMoviePresenter: FavoriteMoviePresenterProtocol {
    public var view: FavoriteMovieViewProtocol?
    
    public var interactor: FavoriteMovieInteractorInputProtocol?
    
    public func viewWillAppear() {
        interactor?.retriveAllFavoriteMovies()
    }
    
    public func loadMoreMovies() {
        
    }
}

extension FavoriteMoviePresenter: FavoriteMovieInteractorOutputProtocol {
    public func onError() {
        
    }
    
    public func didRetrieveFavoriteMovies(_ movies: [MovieEntity]) {
        view?.movieList?.showMovies(movies)
    }
}
