//
//  DetailMoviePresenter.swift
//  YoyoFramework
//
//  Created by Amadeu Cavalcante Filho on 04/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation

final class MovieDetailPresenter: MovieDetailPresenterProtocol {
    var view: MovieDetailViewProtocol?
    
    var interactor: MovieDetailInteractorInputProtocol?
    
    func viewDidLoad() {
        
    }
    
    func favorited(_ movie: MovieEntity) {
        interactor?.favorite(movie.favorited())
    }
    
    func unFavorited(_ movie: MovieEntity) {
        interactor?.unFavorite(movie.unFavorited())
    }
}

extension MovieDetailPresenter: MovieDetailInteractorOutputProtocol {
    func movieDidChange(_ movie: MovieEntity) {
        view?.showMovieDetail(for: movie)
    }
    
    func onError() {
        
    }
}
