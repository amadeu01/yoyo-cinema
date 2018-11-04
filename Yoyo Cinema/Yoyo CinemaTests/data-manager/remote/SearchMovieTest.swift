//
//  SearchMovieTest.swift
//  Yoyo CinemaTests
//
//  Created by Amadeu Cavalcante Filho on 03/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import XCTest
@testable import YoyoFramework

class SearchMovieTest: XCTestCase {
    
    override func setUp() {
        
    }
    
    func testSearchMovieTestSucess() {
        let searchMovieExpectation = self.expectation(description: "Search Movie")
        
        let searchGateway = SearchMovie(webClient: WebClient.shared, query: "star") { result, error in
            XCTAssertNil(error)
            XCTAssertNotNil(result)
            searchMovieExpectation.fulfill()
        }
        
        searchGateway.fetchData()
        wait(for: [searchMovieExpectation], timeout: 5)
    }
}
