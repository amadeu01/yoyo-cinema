//
//  MovieListProtocols.swift
//  Yoyo Cinema
//
//  Created by Amadeu Cavalcante Filho on 02/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation

protocol TrendingMoviesViewProtocol: class {
    var presenter: TrendingMoviesPresenterProtocol? { get set }
    var movieList: MovieListViewProtocol { get set }
}

// MARK: - WireFrame Protocol

protocol TrendingMoviesWireFrameProtocol: class {
    static func createTrendingMovieModule() -> TrendingMoviesViewProtocol
    
    func presentMovieDetail(from view: TrendingMoviesViewProtocol, for movieItem: MovieEntity)
}

// MARK: - Presenter Protocol

protocol TrendingMoviesPresenterProtocol: MovieListDelegate {
    var view: TrendingMoviesViewProtocol? { get set }
    var interactor: TrendingMoviesInteractorInputProtocol? { get set }
    var wireFrame: TrendingMoviesWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

// MARK: - Interactors Protocol

protocol MovieListInteractorOutputProtocol: class {
    func onError(_ error: NetworkError)
    
    func didRetrieveUpcomingMovie(_ movies: [MovieEntity])
}

protocol TrendingMoviesInteractorInputProtocol: class {
    var presenter: MovieListInteractorOutputProtocol? { get set }
    var remoteDatamanager: MovieListRemoteDataManagerInputProtocol? { get set }
    
    func getMovies()
}

// MARK: - Data Manager Protocol

protocol MovieListDataManagerInputProtocol: class {
}

protocol MovieListRemoteDataManagerInputProtocol: class {
    var remoteUpcomingRequestHandler: TredingMovieOutputProtocol? { get set }

    func getUpcomingReleases(forPageAt page: Int)
}

protocol MovieListRemoteDataManagerOutputProtocol: class {
    func onError(_ error: NetworkError)
}

protocol TredingMovieOutputProtocol: MovieListRemoteDataManagerOutputProtocol {
    func onUpcomingMovieRetrieved(_ movies: [MovieEntity])
}
