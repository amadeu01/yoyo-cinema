//
//  JsonObject.swift
//  Yoyo CinemaTests
//
//  Created by Amadeu Cavalcante Filho on 02/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

@testable import Yoyo_Cinema


/*
 "vote_count": 2,
 "id": 482088,
 "video": false,
 "vote_average": 10,
 "title": "Better Start Running",
 "popularity": 1.147,
 "poster_path": "/wv3U9nSjJDWPoSK99da6X8ypJAs.jpg",
 "original_language": "en",
 "original_title": "Better Start Running",
 "genre_ids": [18, 35 ],
 "backdrop_path": "/qRocYlYL9saXW6Eq1bD08rDhXlJ.jpg",
 "adult": false,
 "overview": "An eclectic band of misfits becomes an unlikely family as they take a wild journey in the name of love while on the run from an overzealous FBI duo who want them dead or alive - preferably dead.",
 "release_date": "2018-04-28"
 */

let BetterStartRunningResultMovie =
    MovieResult(adult: false,
                backdropPath: "/qRocYlYL9saXW6Eq1bD08rDhXlJ.jpg",
                genreIDS: [18, 35], id: 482088,
                originalLanguage: "en",
                originalTitle: "Better Start Running",
                overview: "An eclectic band of misfits becomes an unlikely family as they take a wild journey in the name of love while on the run from an overzealous FBI duo who want them dead or alive - preferably dead.",
                posterPath: "/wv3U9nSjJDWPoSK99da6X8ypJAs.jpg",
                releaseDate: "2018-04-28",
                title: "Better Start Running",
                video: false,
                voteAverage: 10,
                voteCount: 2,
                popularity: 1.147)

extension MovieResult: Equatable {
    public static func ==(lhs: MovieResult, rhs: MovieResult) -> Bool {
        guard lhs.adult == rhs.adult else { return false }
        guard lhs.backdropPath == rhs.backdropPath else { return false }
        guard lhs.genreIDS == rhs.genreIDS else { return false }
        guard lhs.id == rhs.id else { return false }
        guard lhs.originalLanguage == rhs.originalLanguage else { return false }
        guard lhs.originalTitle == rhs.originalTitle else { return false }
        guard lhs.overview == rhs.overview else { return false }
        guard lhs.posterPath == rhs.posterPath else { return false }
        guard lhs.releaseDate == rhs.releaseDate else { return false }
        guard lhs.title == rhs.title else { return false }
        guard lhs.video == rhs.video else { return false }
        guard lhs.voteAverage == rhs.voteAverage else { return false }
        guard lhs.voteCount == rhs.voteCount else { return false }
        guard lhs.popularity == rhs.popularity else { return false }
        return true
    }
}

/*
 {
 "adult": false,
 "backdrop_path": "/z6KLDE72SxE1A8JcJTmmnWArOvR.jpg",
 "genre_ids": [28, 80, 53],
 "id": 345887,
 "original_language": "en",
 "original_title": "The Equalizer 2",
 "overview": "Robert McCall, who serves an unflinching justice for the exploited and oppressed, embarks on a relentless, globe-trotting quest for vengeance when a long-time girl friend is murdered.",
 "poster_path": "/cQvc9N6JiMVKqol3wcYrGshsIdZ.jpg",
 "release_date": "2018-07-19",
 "title": "The Equalizer 2",
 "video": false,
 "vote_average": 6.2,
 "vote_count": 764,
 "popularity": 120.497
 }
 */
let TheEqualizer2Movie = MovieResult(
    adult: false,
    backdropPath: "/z6KLDE72SxE1A8JcJTmmnWArOvR.jpg",
    genreIDS: [28, 80, 53],
    id: 345887,
    originalLanguage: "en",
    originalTitle: "The Equalizer 2",
    overview: "Robert McCall, who serves an unflinching justice for the exploited and oppressed, embarks on a relentless, globe-trotting quest for vengeance when a long-time girl friend is murdered.",
    posterPath: "/cQvc9N6JiMVKqol3wcYrGshsIdZ.jpg",
    releaseDate: "2018-07-19",
    title: "The Equalizer 2",
    video: false,
    voteAverage: 6.2,
    voteCount: 764,
    popularity: 120.487)

/*
 {
 "images": {
 "base_url": "http://image.tmdb.org/t/p/",
 "secure_base_url": "https://image.tmdb.org/t/p/",
 "backdrop_sizes": [ "w300", "w780", "w1280", "original" ],
 "logo_sizes": [ "w45", "w92", "w154", "w185", "w300", "w500", "original" ],
 "poster_sizes": [ "w92", "w154", "w185", "w342", "w500", "w780", "original"],
 "profile_sizes": [ "w45", "w185", "h632", "original" ],
 "still_sizes": [ "w92", "w185", "w300", "original"]
 },
 "change_keys": [ "adult", "air_date", "also_known_as", "type", "video", "videos" ]
 }

 */

let ApiConfig = TMDBAPIConfigurationResponse(
    images: Images(
        baseURL: "http://image.tmdb.org/t/p/",
        secureBaseURL: "https://image.tmdb.org/t/p/",
        backdropSizes: [ "w300", "w780", "w1280", "original" ],
        logoSizes: [ "w45", "w92", "w154", "w185", "w300", "w500", "original" ],
        posterSizes: [ "w92", "w154", "w185", "w342", "w500", "w780", "original"],
        profileSizes: [ "w45", "w185", "h632", "original" ],
        stillSizes: [ "w92", "w185", "w300", "original"]),
    changeKeys: [ "adult", "air_date", "also_known_as", "type", "video", "videos" ])


public func adoptEquatable(_ subject: Any) {
    let mirror = Mirror(reflecting: subject)
    
    let typeName: String = {
        let fullTypeName = String(reflecting: mirror.subjectType)
        let typeNameParts = fullTypeName.components(separatedBy: ".")
        let hasModulePrefix = typeNameParts.count > 1
        return hasModulePrefix
            ? typeNameParts.dropFirst().joined(separator: ".")
            : fullTypeName
    }()
    
    let propertyNames = mirror.children.map { $0.label ?? "" }
    
    // Associate an indentation level with each snippet of code.
    typealias TemplateGroup = [(Int, String)]
    let templateGroups: [TemplateGroup] = [
        [(0, "extension \(typeName): Equatable {")],
        [(1, "public static func ==(lhs: \(typeName), rhs: \(typeName)) -> Bool {")],
        propertyNames.map { (2, "guard lhs.\($0) == rhs.\($0) else { return false }") },
        [(2, "return true")],
        [(1, "}")],
        [(0, "}")]
    ]
    
    // Apply indentation to each line of code while flattening the list.
    let indent = "    "
    let linesOfCode = templateGroups.flatMap { templateGroup -> [String] in
        return templateGroup.map { (indentLevel: Int, code: String) -> String in
            let indentation = String(repeating: indent, count: indentLevel)
            return "\(indentation)\(code)"
        }
    }
    
    let sourceCode = linesOfCode.joined(separator: "\n")
    print(sourceCode)
}
