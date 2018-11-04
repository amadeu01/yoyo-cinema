//
//  TMDbConfigurationEntity.swift
//  Yoyo Cinema
//
//  Created by Amadeu Cavalcante Filho on 02/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation

public struct TMDbConfigurationEntity {
    let baseUrl: String?
    let secureBaseUrl: String?
    let backdropSizes: [BackdropSize]
    let logoSizes: [String]
    let posterSizes: [PosterSize]
    let profileSizes: [String]
    let stillSizes: [String]
    let changeKeys: [String]
}

public struct BackdropSize: Comparable {
    let size: String
    let numberSize: Int
    
    init(_ size: String) {
        self.size = size
        switch size {
        case "w300":
            self.numberSize = 1
        case "w780":
            self.numberSize = 2
        case "w1280":
            self.numberSize = 3
        case "original":
            self.numberSize = 4
        default:
            self.numberSize = 0
        }
    }
    
    public static func < (lhs: BackdropSize, rhs: BackdropSize) -> Bool {
        return lhs.numberSize < rhs.numberSize
    }
}

public struct PosterSize: Comparable {
    let size: String
    let numberSize: Int
    
    init(_ size: String) {
        self.size = size
        switch size {
        case "w92":
            self.numberSize = 1
        case "w154":
            self.numberSize = 2
        case "w185":
            self.numberSize = 3
        case "w342":
            self.numberSize = 4
        case "w500":
            self.numberSize = 5
        case "w780":
            self.numberSize = 6
        case "original":
            self.numberSize = 7
        default:
            self.numberSize = 0
        }
    }
    
    public static func < (lhs: PosterSize, rhs: PosterSize) -> Bool {
        return lhs.numberSize < rhs.numberSize
    }
}

extension TMDbConfigurationEntity {
    static func makeEntity(from configResponse: TMDBAPIConfigurationResponse) -> TMDbConfigurationEntity {
        return TMDbConfigurationEntity(
            baseUrl: configResponse.images.baseURL,
            secureBaseUrl: configResponse.images.secureBaseURL,
            backdropSizes: configResponse.images.backdropSizes.map { BackdropSize($0) },
            logoSizes: configResponse.images.logoSizes,
            posterSizes: configResponse.images.posterSizes.map { PosterSize($0) },
            profileSizes: configResponse.images.profileSizes,
            stillSizes: configResponse.images.stillSizes,
            changeKeys: configResponse.changeKeys)
    }
}
