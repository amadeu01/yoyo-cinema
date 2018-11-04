//
//  MovieDetailProtocols.swift
//  Yoyo Cinema
//
//  Created by Amadeu Cavalcante Filho on 02/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation

public protocol MovieDetailViewProtocol: class {
    var presenter: MovieDetailPresenterProtocol? { get set }
    
    func showError()
    
    func showLoading()
    
    func hideLoading()
    
    func showMovieDetail(for movieEntity: MovieEntity)
}

// MARK: - WireFrame Protocol

public protocol MovieDetailWireFrameProtocol: class {
    static func createMovieDetailModule(for movieItem: MovieEntity) -> MovieDetailViewProtocol
}

// MARK: - Presenter Protocol

public protocol MovieDetailPresenterProtocol: class {
    var view: MovieDetailViewProtocol? { get set }
    var interactor: MovieDetailInteractorInputProtocol? { get set }
    
    func viewDidLoad()
    
    func favorited(_ movie: MovieEntity)
    
    func unFavorited(_ movie: MovieEntity)
}

// MARK: - Interactors Protocol

public protocol MovieDetailInteractorOutputProtocol: class {
    func onError()
    
    func movieDidChange(_ movie: MovieEntity)
}

public protocol MovieDetailInteractorInputProtocol: class {
    var presenter: MovieDetailInteractorOutputProtocol? { get set }
    var gateway: FavoriteMovieLocalGatewayProtocol? { get set }
    
    func favorite(_ movie: MovieEntity)
    
    func unFavorite(_ movie: MovieEntity)
}
