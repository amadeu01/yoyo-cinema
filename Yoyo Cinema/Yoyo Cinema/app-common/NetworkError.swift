//
//  NetworkError.swift
//  Yoyo Cinema
//
//  Created by Amadeu Cavalcante Filho on 02/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    case notFound
    case forbidden
    case networkProblem(Error?)
    case unknown(HTTPURLResponse?)
    case notAuthenticated
    case invalidUrl
    
    public init(response: URLResponse?) {
        guard let response = response as? HTTPURLResponse else {
            self = .unknown(nil)
            return
        }
        switch response.statusCode {
        case NetworkError.notAuthenticated.statusCode: self = .notAuthenticated
        case NetworkError.forbidden.statusCode: self = .forbidden
        case NetworkError.notFound.statusCode: self = .notFound
        default: self = .unknown(response)
        }
    }
    
    public var isAuthError: Bool {
        switch self {
        case .notAuthenticated: return true
        default: return false
        }
    }
    
    public init(error: Error) {
        self = .networkProblem(error)
    }
    
    public var statusCode: Int {
        switch self {
        case .notAuthenticated: return 401
        case .forbidden:        return 403
        case .notFound:         return 404
            
        case .networkProblem(_): return 10001
        case .unknown(_):        return 10002
        case .invalidUrl:        return 10003
        }
    }
}

extension NetworkError: Equatable {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        return lhs.statusCode == rhs.statusCode
    }
}
