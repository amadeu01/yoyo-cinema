//
//  FavoriteWireFrame.swift
//  YoyoFramework
//
//  Created by Amadeu Cavalcante Filho on 03/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation
import UIKit

public class FavoriteWireFrame: FavoriteMovieWireFrameProtocol {
    public static func createFavoriteMovieModule() -> FavoriteMovieViewProtocol {
        let favoriteView = FavoriteMovieView()
        let interactor = FavoriteMovieInteractor()
        let presenter = FavoriteMoviePresenter()
        let localGateway = FavoriteMovieGateway()
        let movieList = MovieListView()
        
        favoriteView.presenter = presenter
        favoriteView.movieList = movieList
        presenter.interactor = interactor
        presenter.view = favoriteView
        
        interactor.gateway = localGateway
        interactor.presenter = presenter
        
        movieList.movieListDelegate = presenter
        
        favoriteView.tabBarItem.title = "Favorites"
        favoriteView.tabBarItem.image = UIImage(named: "movie-icon")
        
        return favoriteView
    }
    
}
