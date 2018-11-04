//
//  MovieDetailWireFrame.swift
//  Yoyo Cinema
//
//  Created by Amadeu Cavalcante Filho on 02/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation

public class MovieDetailWireFrame: MovieDetailWireFrameProtocol {
    public static func createMovieDetailModule(for movieItem: MovieEntity) -> MovieDetailViewProtocol {
        let detailView = MovieDetailView()
        detailView.movieEntity = movieItem
        let localGateway = FavoriteMovieGateway()
        let presenter = MovieDetailPresenter()
        let interactor = DetailMovieInteractor()
        
        interactor.presenter = presenter
        interactor.gateway = localGateway
        presenter.interactor = interactor
        detailView.presenter = presenter
        presenter.view = detailView
        
        return detailView
    }
}
