//
//  SearchMovieProtocol.swift
//  Yoyo Cinema
//
//  Created by Amadeu Cavalcante Filho on 02/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation

public protocol SearchMovieViewProtocol: class {
    var presenter: SearchMoviePresenterProtocol? { get set }
    var movieList: MovieListViewProtocol? { get set }
}

// MARK: - WireFrame Protocol

public protocol SearchMovieWireFrameProtocol: class {
    static func createSearchMovieModule() -> SearchMovieViewProtocol
}

// MARK: - Presenter Protocol

public protocol SearchMoviePresenterProtocol: MovieListDelegate {
    var view: SearchMovieViewProtocol? { get set }
    var searchInteractor: SearchMovieInteractorInputProtocol? { get set }
    var wireFrame: SearchMovieWireFrameProtocol? { get set }
    
    func viewDidLoad()
    
    func viewWillAppear()
    
    func searchMovie(matching query: String)
}

// MARK: - Interactors Protocol

public protocol SearchMovieInteractorOutputProtocol: class {
    func onError()
    
    func didRetrieveMovies(_ movies: [MovieEntity], for query: String)
}

public protocol SearchMovieInteractorInputProtocol: class {
    var presenter: SearchMovieInteractorOutputProtocol? { get set }
    var remoteDataManager: WebClientProtocol? { get set }
    
    func searchMovie(by query: String, at page: Int)
}

// MARK: - Data Manager Protocol

protocol SearchMovieRemoteDataManagerOutputProtocol: class {
    
    func onError(_ error: NetworkError)
}

protocol SearchMovieOutputProtocol: SearchMovieRemoteDataManagerOutputProtocol {
    func moviesRetrieved(_ movies: [MovieEntity])
}

protocol SearchMovieLocalDataManagerInputProtocol: class {
    func searchMovie(by title: String) throws
}

protocol SearchMovieLocalDataManagerOutputProtocol: class {
    func moviesRetrieved(_ movies: [MovieEntity])
}


