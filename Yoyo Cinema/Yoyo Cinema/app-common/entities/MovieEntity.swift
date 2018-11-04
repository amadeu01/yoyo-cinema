//
//  MovieEntity.swift
//  Yoyo Cinema
//
//  Created by Amadeu Cavalcante Filho on 02/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

public struct MovieEntity: Hashable, Equatable {
    let id: Int
    let title, originalTitle: String
    let adult: Bool
    let video: Bool
    let releaseDate: String
    let voteCount: Int
    let backdropPath: String?
    let budget: Int?
    let genres: [GenreEntity]
    let homepage: String?
    let originalLanguage, overview: String?
    let popularity: Double?
    let posterPath: String?
    let revenue, runtime: Int?
    let status, tagline: String?
    let voteAverage: Double?
    let favorite: Bool
    
    let posterUrl: String?
    let backdropUrl: String?
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(releaseDate)
    }
    
    public static func ==(lhs: MovieEntity, rhs: MovieEntity) -> Bool {
        guard lhs.id == rhs.id else { return false }
        guard lhs.title == rhs.title else { return false }
        guard lhs.originalTitle == rhs.originalTitle else { return false }
        guard lhs.adult == rhs.adult else { return false }
        guard lhs.video == rhs.video else { return false }
        guard lhs.releaseDate == rhs.releaseDate else { return false }
        guard lhs.voteCount == rhs.voteCount else { return false }
        guard lhs.budget == rhs.budget else { return false }
        guard lhs.genres == rhs.genres else { return false }
        guard lhs.homepage == rhs.homepage else { return false }
        guard lhs.originalLanguage == rhs.originalLanguage else { return false }
        guard lhs.overview == rhs.overview else { return false }
        guard lhs.popularity == rhs.popularity else { return false }
        guard lhs.revenue == rhs.revenue else { return false }
        guard lhs.runtime == rhs.runtime else { return false }
        guard lhs.status == rhs.status else { return false }
        guard lhs.tagline == rhs.tagline else { return false }
        return true
    }
}

extension MovieEntity {
    static public let empty = MovieEntity(
        id: -1,
        title: "",
        originalTitle: "",
        adult: false,
        video: false,
        releaseDate: "",
        voteCount: 0,
        backdropPath: "",
        budget: -1,
        genres: [GenreEntity](),
        homepage: "",
        originalLanguage: "",
        overview: "",
        popularity: 0,
        posterPath: "",
        revenue: 0,
        runtime: 0, status: "",
        tagline: "",
        voteAverage: 0,
        favorite: false,
        posterUrl: nil,
        backdropUrl: nil)
    
}

extension MovieEntity {
    static func makeEntity(from getMovieDetailResponse: GetMovieDetailResponse) -> MovieEntity {
        return MovieEntity(
            id: getMovieDetailResponse.id ?? -1,
            title: getMovieDetailResponse.title ?? "",
            originalTitle: getMovieDetailResponse.originalTitle ?? "",
            adult: getMovieDetailResponse.adult ?? false,
            video: getMovieDetailResponse.adult ?? false,
            releaseDate: getMovieDetailResponse.releaseDate ?? "",
            voteCount: getMovieDetailResponse.voteCount ?? 0,
            backdropPath: getMovieDetailResponse.backdropPath ?? "",
            budget: getMovieDetailResponse.budget,
            genres: [],
            homepage: getMovieDetailResponse.homepage,
            originalLanguage: getMovieDetailResponse.originalTitle ?? "",
            overview: getMovieDetailResponse.overview ?? "",
            popularity: getMovieDetailResponse.popularity ?? 0,
            posterPath: getMovieDetailResponse.posterPath ?? "",
            revenue: getMovieDetailResponse.revenue ?? 0,
            runtime: getMovieDetailResponse.runtime ?? 0,
            status: getMovieDetailResponse.status ?? "Unkown",
            tagline: getMovieDetailResponse.tagline ?? "",
            voteAverage: getMovieDetailResponse.voteAverage ?? 0,
            favorite: false,
            posterUrl: nil,
            backdropUrl: nil)
    }
    
    public static func makeEntity(from movieResult: MovieResult) -> MovieEntity {
        return MovieEntity(
            id: movieResult.id ?? -1,
            title: movieResult.title ?? "",
            originalTitle: movieResult.originalTitle ?? "",
            adult: movieResult.adult ?? false,
            video: movieResult.adult ?? false,
            releaseDate: movieResult.releaseDate ?? "",
            voteCount: movieResult.voteCount ?? 0,
            backdropPath: movieResult.backdropPath ?? "",
            budget: 0,
            genres: [],
            homepage: "",
            originalLanguage: movieResult.originalTitle ?? "",
            overview: movieResult.overview ?? "",
            popularity: movieResult.popularity ?? 0,
            posterPath: movieResult.posterPath ?? "",
            revenue: 0,
            runtime: 0,
            status: "Unkown",
            tagline: "",
            voteAverage: movieResult.voteAverage ?? 0,
            favorite: false,
            posterUrl: nil,
            backdropUrl: nil)
    }
    
    static func makeEntities(from searchMovieResponse: SearchMovieResponse) -> [MovieEntity] {
        return searchMovieResponse.results?.map { MovieEntity.makeEntity(from: $0) } ?? []
    }
    
    func updateImageUrls(with apiConfiguration: TMDbConfigurationEntity) -> MovieEntity {
        if let baseUrl = apiConfiguration.secureBaseUrl,
            let posterPath = posterPath,
            let backdropPath = backdropPath,
            let posterMaxSize = apiConfiguration.posterSizes.max(),
            let backdropMaxSize = apiConfiguration.backdropSizes.max() {
            let posterUrl = baseUrl + posterMaxSize.size + posterPath
            let backdropUrl = baseUrl + backdropMaxSize.size + backdropPath
            
            return updateImageUrls(posterUrl, backdropUrl)
        }
        
        return self
    }
    
    private func updateImageUrls(_ posterUrl: String, _ backdropUrl: String) -> MovieEntity {
        return MovieEntity(
            id: id,
            title: title,
            originalTitle: originalTitle,
            adult: adult,
            video: video,
            releaseDate: releaseDate,
            voteCount: voteCount,
            backdropPath: backdropPath,
            budget: budget,
            genres: genres,
            homepage: homepage,
            originalLanguage: originalLanguage,
            overview: overview,
            popularity: popularity,
            posterPath: posterPath,
            revenue: revenue,
            runtime: runtime,
            status: status,
            tagline: tagline,
            voteAverage: voteAverage,
            favorite: false,
            posterUrl: posterUrl,
            backdropUrl: backdropUrl)
    }
    
    public func favorited() -> MovieEntity {
        return MovieEntity(
            id: id,
            title: title,
            originalTitle: originalTitle,
            adult: adult,
            video: video,
            releaseDate: releaseDate,
            voteCount: voteCount,
            backdropPath: backdropPath,
            budget: budget,
            genres: genres,
            homepage: homepage,
            originalLanguage: originalLanguage,
            overview: overview,
            popularity: popularity,
            posterPath: posterPath,
            revenue: revenue,
            runtime: runtime,
            status: status,
            tagline: tagline,
            voteAverage: voteAverage,
            favorite: true,
            posterUrl: posterUrl,
            backdropUrl: backdropUrl)
    }
    
    public func unFavorited() -> MovieEntity {
        return MovieEntity(
            id: id,
            title: title,
            originalTitle: originalTitle,
            adult: adult,
            video: video,
            releaseDate: releaseDate,
            voteCount: voteCount,
            backdropPath: backdropPath,
            budget: budget,
            genres: genres,
            homepage: homepage,
            originalLanguage: originalLanguage,
            overview: overview,
            popularity: popularity,
            posterPath: posterPath,
            revenue: revenue,
            runtime: runtime,
            status: status,
            tagline: tagline,
            voteAverage: voteAverage,
            favorite: false,
            posterUrl: posterUrl,
            backdropUrl: backdropUrl)
    }
}
