//
//  GetMovieDetail.swift
//  Yoyo Cinema
//
//  Created by Amadeu Cavalcante Filho on 02/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation

class GetMovieDetail: GetMovieDetailGatewayProtocol {
    var webClient: WebClientProtocol
    
    let completionHandler: (MovieEntity?, NetworkError?) -> Void
    let url: URL
    
    required init(webClient: WebClientProtocol, for id: Int,
                  _ completionHandler: @escaping ((MovieEntity?, NetworkError?) -> Void)) {
        let endpoint = Endpoints.MovieDetail.fetch(id)
        self.url = URLComponents(string: endpoint.url)!.url!
        self.completionHandler = completionHandler
        self.webClient = webClient
    }
    
    func fetchData() {
        webClient.fetchData(url: url, queue: DispatchQueue.main) { (data, error) in
            if let error = error {
                self.completionHandler(nil, error)
            }
            
            guard let data = data else { return }
            
            let getMovieDetailResponse = try! JSONDecoder().decode(GetMovieDetailResponse.self, from: data)
            self.completionHandler(MovieEntity.makeEntity(from: getMovieDetailResponse), nil)
        }
    }
}
