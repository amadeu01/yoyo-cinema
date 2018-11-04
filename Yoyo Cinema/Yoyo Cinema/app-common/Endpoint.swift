//
//  Endpoint.swift
//  Yoyo Cinema
//
//  Created by Amadeu Cavalcante Filho on 02/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation

struct API {
    static let baseUrl = Secrets.Api.Endpoint.production
    static let apiKey = Secrets.Api.Client.keyV3Auth
}

protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

enum Endpoints {
    
    enum Search: Endpoint {
        case movie
        case person
        
        public var path: String {
            switch self {
            case .movie: return "/search/movie"
            case .person: return "/search/person"
            }
        }
        
        public var url: String {
            switch self {
            case .movie: return "\(API.baseUrl)\(path)?api_key=\(API.apiKey)"
            case .person: return "\(API.baseUrl)\(path)?api_key=\(API.apiKey)"
            }
        }
    }
    
    enum TredingMovie: Endpoint {
        case week
        case day
        
        var path: String {
            switch self {
            case .week: return "/trending/movie/week"
            case .day: return "/trending/movie/day"
            }
        }
        
        var url: String {
            switch self {
            case .week: return "\(API.baseUrl)\(path)?api_key=\(API.apiKey)"
            case .day: return "\(API.baseUrl)\(path)?api_key=\(API.apiKey)"
            }
        }
        
    }
    
    enum ApiConfiguration: Endpoint {
        case fetch
        
        public var path: String {
            switch self {
            case .fetch: return "/configuration"
            }
        }
        
        public var url: String {
            switch self {
            case .fetch: return "\(API.baseUrl)\(path)?api_key=\(API.apiKey)"
            }
        }
    }
    
    enum MovieDetail: Endpoint {
        case fetch(Int)
        
        public var path: String {
            switch self {
            case .fetch(let id): return "/movie/\(id)"
            }
        }
        
        public var url: String {
            switch self {
            case .fetch(_): return "\(API.baseUrl)\(path)?api_key=\(API.apiKey)"
            }
        }
    }
}
