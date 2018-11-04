//
//  Interactor.swift
//  YoyoFramework
//
//  Created by Amadeu Cavalcante Filho on 04/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation

final class DetailMovieInteractor: MovieDetailInteractorInputProtocol {
    var presenter: MovieDetailInteractorOutputProtocol?
    
    var gateway: FavoriteMovieLocalGatewayProtocol?
    
    func favorite(_ movie: MovieEntity) {
        gateway?.favorite(movie: movie)
    }
}
