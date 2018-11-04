//
//  Protocols.swift
//  Yoyo Cinema
//
//  Created by Amadeu Cavalcante Filho on 02/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//


public protocol FavoriteMovieViewProtocol: class {
    var presenter: FavoriteMoviePresenterProtocol? { get set }
    var movieList: MovieListViewProtocol? { get set }
}

// MARK: - WireFrame Protocol

public protocol FavoriteMovieWireFrameProtocol: class {
    static func createFavoriteMovieModule() -> FavoriteMovieViewProtocol
}

// MARK: - Presenter Protocol

public protocol FavoriteMoviePresenterProtocol: MovieListDelegate {
    var view: FavoriteMovieViewProtocol? { get set }
    var interactor: FavoriteMovieInteractorInputProtocol? { get set }
    
    func viewWillAppear()
}

// MARK: - Interactors Protocol

public protocol FavoriteMovieInteractorOutputProtocol: class {
    func onError()
    
    func didRetrieveFavoriteMovies(_ movies: [MovieEntity])
}

public protocol FavoriteMovieInteractorInputProtocol: class {
    var presenter: FavoriteMovieInteractorOutputProtocol? { get set }
    var gateway: FavoriteMovieLocalGatewayProtocol? { get set }
    
    func retriveAllFavoriteMovies()
}

// MARK: - Data Manager Protocol

public protocol FavoriteMovieLocalDataManagerOutputProtocol: class {
    func didRetrieveFavoriteMovies(_ movies: [MovieEntity])
}
