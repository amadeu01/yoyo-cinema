//
//  MockedProtocols.swift
//  Yoyo CinemaTests
//
//  Created by Amadeu Cavalcante Filho on 04/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation
@testable import Yoyo_Cinema

final class MockedMovieListViewProtocol: MovieListViewProtocol {
    var movieListDelegate: MovieListDelegate?
    
    var showMoviesInvoked = false
    var showMoviesResponse: [MovieEntity]? = nil
    
    var showErrorInvoked = false
    var showLoadingInvoked = false
    var hideLoadingInvoked = false
    
    func showError() {
        showErrorInvoked = true
    }
    
    func showLoading() {
        showLoadingInvoked = true
    }
    
    func hideLoading() {
        hideLoadingInvoked = true
    }
    
    func showMovies(_ movies: [MovieEntity]) {
        showMoviesInvoked = true
        showMoviesResponse = movies
    }
}
