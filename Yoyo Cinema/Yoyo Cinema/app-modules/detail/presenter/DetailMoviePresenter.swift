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
}

extension MovieDetailPresenter: MovieDetailInteractorOutputProtocol {
    func onError() {
        
    }
}
