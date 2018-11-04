//
//  SearchMovieInteractorTest.swift
//  Yoyo CinemaTests
//
//  Created by Amadeu Cavalcante Filho on 04/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation
import XCTest
@testable import Yoyo_Cinema

class SearchMovieInteractorTest: XCTestCase {
    fileprivate var webClient = MockWebClient()
    fileprivate var interactor: SearchMovieInteractor!
    fileprivate var apiResponse: TMDBAPIConfigurationResponse!
    fileprivate var searchOutput = MockSearchMovieInteractorOutput()
    fileprivate var searchMovieResponse: SearchMovieResponse!
    fileprivate let resourceLoader = ResourceLoader()
    
    override func setUp() {
        interactor = SearchMovieInteractor()
        interactor.presenter = searchOutput
        interactor.remoteDataManager = webClient
        
        apiResponse = try! JSONDecoder()
            .decode(TMDBAPIConfigurationResponse.self,
                    from: resourceLoader.loadJsonFile("get_api_configuration"))
        searchMovieResponse = try! JSONDecoder()
            .decode(SearchMovieResponse.self,
                    from: resourceLoader.loadJsonFile("search_movie_response"))
    }
    
    func testSearchMovieWhenFoundMovieThenReceiveArrayOfMovies() {
        let searchMovieExpectation = self.expectation(description: "Search Moview")
        searchMovieExpectation.isInverted = true
        webClient.returnData.append(contentsOf: [resourceLoader.loadJsonFile("search_movie_response"),
                                                 resourceLoader.loadJsonFile("get_api_configuration")])
        
        interactor.searchMovie(by: "test")
        wait(for: [searchMovieExpectation], timeout: 2)
        XCTAssertTrue(searchOutput.didRetrieveMoviesInvoked)
        XCTAssertNotNil(searchOutput.didRetrieveMoviesQueryResponse)
        XCTAssertNotNil(searchOutput.didRetrieveMoviesResponse)
        XCTAssertEqual(2, webClient.fetchDataInvokedTimes)
    }
    
    func testSearchMovieWhenNotFoundMovieThenReceiveOnError() {
        let searchMovieExpectation = self.expectation(description: "Search Moview")
        searchMovieExpectation.isInverted = true
        
        interactor.searchMovie(by: "test")
        wait(for: [searchMovieExpectation], timeout: 2)
        XCTAssertTrue(searchOutput.onErrorInvoked)
        
    }
}
