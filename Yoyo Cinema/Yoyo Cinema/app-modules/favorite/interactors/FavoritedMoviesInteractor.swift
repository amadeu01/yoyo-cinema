//
//  FavoritedMoviesInteractor.swift
//  YoyoFramework
//
//  Created by Amadeu Cavalcante Filho on 04/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation

final class FavoriteMovieInteractor: FavoriteMovieInteractorInputProtocol {
    var gateway: FavoriteMovieLocalGatewayProtocol?
    var presenter: FavoriteMovieInteractorOutputProtocol?
    
    func retriveAllFavoriteMovies() {
        if let movies = gateway?.retriveAllFavoriteMovies() {
            presenter?.didRetrieveFavoriteMovies(movies)
        }
    }
}
