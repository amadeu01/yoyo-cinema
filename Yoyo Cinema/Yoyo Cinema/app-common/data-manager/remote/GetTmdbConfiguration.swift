//
//  GetTmdbConfiguration.swift
//  YoyoFramework
//
//  Created by Amadeu Cavalcante Filho on 03/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation

final class GetTmdbConfigurationRemoteGateway: GetTMDbConfigurationGatewayProtocol {
    var webClient: WebClientProtocol
    let completionHandler: (TMDbConfigurationEntity?, NetworkError?) -> Void
    let url: URL
    
    required init(webClient: WebClientProtocol,
                  _ completionHandler: @escaping ((TMDbConfigurationEntity?, NetworkError?) -> Void)) {
        self.webClient = webClient
        self.completionHandler = completionHandler
        let endpoint = Endpoints.ApiConfiguration.fetch
        self.url = URLComponents(string: endpoint.url)!.url!
    }

    func fetchData() {
        webClient.fetchData(url: url, queue: DispatchQueue.global(qos: .background)) { (data, error) in
            if let error = error {
                self.completionHandler(nil, error)
            }
            
            guard let data = data else { return }
            
            let configResponse = try! JSONDecoder().decode(TMDBAPIConfigurationResponse.self, from: data)
            self.completionHandler(TMDbConfigurationEntity.makeEntity(from: configResponse), nil)
        }
    }
}
