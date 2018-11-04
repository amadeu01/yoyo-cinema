//
//  TMDbApiConfigurationResponse.swift
//  Yoyo Cinema
//
//  Created by Amadeu Cavalcante Filho on 02/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation

struct TMDBAPIConfigurationResponse: Codable {
    let images: Images
    let changeKeys: [String]
    
    enum CodingKeys: String, CodingKey {
        case images
        case changeKeys = "change_keys"
    }
}

struct Images: Codable {
    let baseURL: String
    let secureBaseURL: String
    let backdropSizes, logoSizes, posterSizes, profileSizes: [String]
    let stillSizes: [String]
    
    enum CodingKeys: String, CodingKey {
        case baseURL = "base_url"
        case secureBaseURL = "secure_base_url"
        case backdropSizes = "backdrop_sizes"
        case logoSizes = "logo_sizes"
        case posterSizes = "poster_sizes"
        case profileSizes = "profile_sizes"
        case stillSizes = "still_sizes"
    }
}

extension TMDBAPIConfigurationResponse: Equatable {
    public static func ==(lhs: TMDBAPIConfigurationResponse, rhs: TMDBAPIConfigurationResponse) -> Bool {
        guard lhs.images == rhs.images else { return false }
        guard lhs.changeKeys == rhs.changeKeys else { return false }
        return true
    }
}

extension Images: Equatable {
    public static func ==(lhs: Images, rhs: Images) -> Bool {
        guard lhs.baseURL == rhs.baseURL else { return false }
        guard lhs.secureBaseURL == rhs.secureBaseURL else { return false }
        guard lhs.backdropSizes == rhs.backdropSizes else { return false }
        guard lhs.logoSizes == rhs.logoSizes else { return false }
        guard lhs.posterSizes == rhs.posterSizes else { return false }
        guard lhs.profileSizes == rhs.profileSizes else { return false }
        guard lhs.stillSizes == rhs.stillSizes else { return false }
        return true
    }
}
