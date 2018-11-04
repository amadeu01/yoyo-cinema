//
//  SearchMovie.swift
//  Yoyo Cinema
//
//  Created by Amadeu Cavalcante Filho on 02/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation

final class SearchMovieGateway: SearchMovieGatewayProtocol {
    var webClient: WebClientProtocol
    
    let completionHandler: ([MovieEntity]?, NetworkError?) -> Void
    let url: URL
    
    required init(webClient: WebClientProtocol, query: String, page: Int = 1,
                  _ completionHandler: @escaping ([MovieEntity]?, NetworkError?) -> Void) {
        let endpoint = Endpoints.Search.movie
        var urlComponents = URLComponents(string: endpoint.url)!
        urlComponents.queryItems?.append(contentsOf: [URLQueryItem(name: "query", value: query),
                                                      URLQueryItem(name: "page", value: "\(page)")])
        self.url = urlComponents.url!
        self.completionHandler = completionHandler
        self.webClient = webClient
    }
    
    func fetchData() {
        webClient.fetchData(url: url, queue: DispatchQueue.main) { (data, error) in
            if let error = error {
                self.completionHandler(nil, error)
            }
            
            guard let data = data else { return }
            
            let searchMovieResponse = try! JSONDecoder().decode(SearchMovieResponse.self, from: data)
            self.completionHandler(MovieEntity.makeEntities(from: searchMovieResponse), nil)
        }
    }
}
