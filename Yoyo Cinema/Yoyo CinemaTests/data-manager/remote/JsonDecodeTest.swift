//
//  SerializationTest.swift
//  Yoyo CinemaTests
//
//  Created by Amadeu Cavalcante Filho on 02/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import XCTest
@testable import Yoyo_Cinema

class JsonDecodeTest: XCTestCase {
    fileprivate let resourceLoader: ResourceLoader = ResourceLoader()
    
    func testShouldBeAbleToDecodeGetMovieDetailResponse() {
        let getMovieDetailResponse = try! JSONDecoder()
            .decode(GetMovieDetailResponse.self,
                    from: resourceLoader.loadJsonFile("get_movie_detail_response"))
        
        XCTAssertEqual(2, getMovieDetailResponse.id)
        XCTAssertEqual("Taisto Kasurinen is a Finnish coal miner whose father has just committed suicide and who is framed for a crime he did not commit. In jail, he starts to dream about leaving the country and starting a new life. He escapes from prison but things don't go as planned...",
                       getMovieDetailResponse.overview)
        XCTAssertEqual(7.091225, getMovieDetailResponse.popularity)
        XCTAssertEqual("Ariel", getMovieDetailResponse.title)
        XCTAssertEqual("Released", getMovieDetailResponse.status)
        XCTAssertEqual("/z2QUexmccqrvw1kDMw3R8TxAh5E.jpg", getMovieDetailResponse.backdropPath)
    }
    
    func testShouldBeAbleToDecodeSearchMovieResponse() {
        let searchMovieResponse = try! JSONDecoder()
            .decode(SearchMovieResponse.self,
                    from: resourceLoader.loadJsonFile("search_movie_response"))
        
        XCTAssertEqual(1, searchMovieResponse.page)
        XCTAssertEqual(176, searchMovieResponse.totalResults)
        XCTAssertEqual(9, searchMovieResponse.totalPages)
        XCTAssertEqual(BetterStartRunningResultMovie, searchMovieResponse.results?.first)
    }
    
    func testShouldBeAbleToDecodeApiConfigurationResponse() {
        let apiResponse = try! JSONDecoder()
            .decode(TMDBAPIConfigurationResponse.self,
                    from: resourceLoader.loadJsonFile("get_api_configuration"))
        
        XCTAssertEqual(ApiConfig, apiResponse)
        
    }
    
}
