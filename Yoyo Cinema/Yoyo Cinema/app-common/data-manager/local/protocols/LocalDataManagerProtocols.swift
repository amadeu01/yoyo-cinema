//
//  LocalDataManagerProtocols.swift
//  YoyoFramework
//
//  Created by Amadeu Cavalcante Filho on 03/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation

public protocol FavoriteMovieLocalGatewayProtocol: class {
    func isMovieFavorited(_ movie: MovieEntity) -> Bool
    func retriveAllFavoriteMovies() -> [MovieEntity]
    func favorite(movie: MovieEntity)
    func unFavorite(movie: MovieEntity)
}
