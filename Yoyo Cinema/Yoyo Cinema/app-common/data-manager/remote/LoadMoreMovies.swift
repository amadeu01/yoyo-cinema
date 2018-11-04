//
//  LoadMoreMovies.swift
//  Yoyo Cinema
//
//  Created by Amadeu Cavalcante Filho on 02/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation

final class LoadMoreMoviesGateway: LoadMoreMovieGatewayProtocol {
    var webClient: WebClientProtocol
    let page: Int
    let completionHandler: ([MovieEntity]?, NetworkError?) -> Void
    
    init(webClient: WebClientProtocol, page: Int, _ completionHandler: @escaping ([MovieEntity]?, NetworkError?) -> Void) {
        self.webClient = webClient
        self.page = page
        self.completionHandler = completionHandler
    }
    
    func fetchData() {
        
    }
}
