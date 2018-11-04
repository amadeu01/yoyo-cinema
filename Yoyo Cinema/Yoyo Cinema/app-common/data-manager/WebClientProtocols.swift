//
//  Protocols.swift
//  Yoyo Cinema
//
//  Created by Amadeu Cavalcante Filho on 03/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//
import Foundation

public protocol WebClientProtocol: class {
    func fetchData(url: URL, queue: DispatchQueue, _ completionHandler: @escaping (Data?, NetworkError?) -> Void)
}

public protocol WebGatewayProtocol: class {
    var webClient: WebClientProtocol { get set }
    func fetchData()
}

public protocol SearchMovieGatewayProtocol: WebGatewayProtocol {
    init(webClient: WebClientProtocol, query: String, page: Int,
         _ completionHandler: @escaping ([MovieEntity]?, NetworkError?) -> Void)
}

public protocol LoadMoreMovieGatewayProtocol: WebGatewayProtocol {
    init(webClient: WebClientProtocol, page: Int,
         _ completionHandler: @escaping ([MovieEntity]?, NetworkError?) -> Void)
}

public protocol GetMovieDetailGatewayProtocol: WebGatewayProtocol {
    init(webClient: WebClientProtocol, for id: Int,
         _ completionHandler: @escaping ((MovieEntity?, NetworkError?) -> Void))
}

public protocol GetTMDbConfigurationGatewayProtocol: WebGatewayProtocol {
    init(webClient: WebClientProtocol,
         _ completionHandler: @escaping ((TMDbConfigurationEntity?, NetworkError?) -> Void))
}
