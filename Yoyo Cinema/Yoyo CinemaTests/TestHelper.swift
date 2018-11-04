//
//  TestHelper.swift
//  Yoyo CinemaTests
//
//  Created by Amadeu Cavalcante Filho on 03/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation
@testable import YoyoFramework

public final class MockWebClient: WebClientProtocol {
    public var fetchDataInvoked = false
    public var returnData: Data? = nil
    public var returnError: NetworkError? = nil
    
    public func fetchData(url: URL, queue: DispatchQueue, _ completionHandler: @escaping (Data?, NetworkError?) -> Void) {
        fetchDataInvoked = true
        completionHandler(returnData, returnError)
    }
}
