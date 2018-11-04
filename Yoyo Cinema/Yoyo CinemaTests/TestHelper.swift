//
//  TestHelper.swift
//  Yoyo CinemaTests
//
//  Created by Amadeu Cavalcante Filho on 03/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation
@testable import Yoyo_Cinema

public final class MockWebClient: WebClientProtocol {
    public var fetchDataInvokedTimes = 0
    public var returnData = [Data]()
    public var returnError = [NetworkError]()
    
    public func fetchData(url: URL, queue: DispatchQueue, _ completionHandler: @escaping (Data?, NetworkError?) -> Void) {
        fetchDataInvokedTimes += 1
        completionHandler(returnData.popLast(), returnError.popLast())
    }
}
