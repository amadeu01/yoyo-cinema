//
//  SearchMovieWireFrame.swift
//  Yoyo Cinema
//
//  Created by Amadeu Cavalcante Filho on 03/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import UIKit

public final class SearchMovieWireFrame: SearchMovieWireFrameProtocol {
    public static func createSearchMovieModule() -> SearchMovieViewProtocol {
        let searchWireFrame = SearchMovieWireFrame()
        let movieList = MovieListView()
        let searchMovieView = SearchMovieView()
        let searchInteractor = SearchMovieInteractor()
        let searchPresenter = SearchMoviePresenter(view: searchMovieView,
                                                   searchInteractor: searchInteractor,
                                                   wireFrame: searchWireFrame)
        searchInteractor.presenter = searchPresenter
        searchInteractor.remoteDataManager = WebClient.shared
        
        movieList.movieListDelegate = searchPresenter
        searchMovieView.movieList = movieList
        searchMovieView.presenter = searchPresenter
        
        searchMovieView.tabBarItem.title = "Search"
        searchMovieView.tabBarItem.image = UIImage(named: "search-icon")
        
        return searchMovieView
    }
}
