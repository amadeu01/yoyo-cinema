//
//  GetDetailMovie.swift
//  Yoyo CinemaTests
//
//  Created by Amadeu Cavalcante Filho on 03/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import XCTest
@testable import YoyoFramework

class GetDetailMovieTest: XCTestCase {
    
    func testGetDetailMovieTestSucess() {
        let getMovieExpectation = self.expectation(description: "Get Movie Detail")
        
        let getMovieGateway = GetMovieDetail(webClient: WebClient.shared, for: 11) { result, error in
            print(result)
            getMovieExpectation.fulfill()
        }
        
        getMovieGateway.fetchData()
        
        wait(for: [getMovieExpectation], timeout: 5)
    }
}
