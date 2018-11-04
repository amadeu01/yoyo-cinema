//
//  WebClient.swift
//  YoyoFramework
//
//  Created by Amadeu Cavalcante Filho on 03/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation

public final class WebClient: WebClientProtocol {
    fileprivate let session: URLSession
    
    public static let shared: WebClient = {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        return WebClient(session)
    }()
    
    private init(_ session: URLSession) {
        self.session = session
    }
    
    public func fetchData(url: URL, queue: DispatchQueue = DispatchQueue.main,
        _ completionHandler: @escaping (Data?, NetworkError?) -> Void) {
        let success: (Data) -> Void = { data in
            queue.async { completionHandler(data, nil) }
        }
        let failure: (NetworkError) -> Void = { error in
            queue.async { completionHandler(nil, error) }
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode.isSuccessHTTPCode,
                let data = data else {
                    if let error = error {
                        failure(NetworkError(error: error))
                    } else {
                        failure(NetworkError(response: response))
                    }
                    return
            }
            
            success(data)
        }
        
        task.resume()
    }
}

extension Int {
    public var isSuccessHTTPCode: Bool {
        return 200 <= self && self < 300
    }
}
