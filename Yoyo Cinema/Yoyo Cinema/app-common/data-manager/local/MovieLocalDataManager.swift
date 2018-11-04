//
//  MovieLocalDataManager.swift
//  YoyoFramework
//
//  Created by Amadeu Cavalcante Filho on 03/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation
import CoreData

public class MovieLocalDataManager {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    func getConfigurationEntity() throws -> TMDbConfigurationEntity {
        let localConfig = try getTMDbApiConfigurationEntity()
        
        return TMDbConfigurationEntity(
            baseUrl: localConfig.baseUrl,
            secureBaseUrl: localConfig.secureBaseUrl,
            backdropSizes: localConfig.backdropSizes.map { BackdropSize($0)},
            logoSizes: localConfig.logoSizes,
            posterSizes: localConfig.backdropSizes.map { PosterSize($0)},
            profileSizes: localConfig.profileSizes,
            stillSizes: localConfig.stillSizes,
            changeKeys: localConfig.changeKeys
        )
    }
    
    func getTMDbApiConfigurationEntity() throws -> TMDbApiConfiguration {
        let request: NSFetchRequest<TMDbApiConfiguration> = TMDbApiConfiguration.fetchRequest()
        let fetchedObjectContext = try managedObjectContext.fetch(request)
        
        guard fetchedObjectContext.count == 1,
            let fetchedConfiguration = fetchedObjectContext.first else {
                throw PersistenceError.objectNotFound
        }
        
        return fetchedConfiguration
    }
    
    func searchMovie(forTitle title: String) throws -> [Movie] {
        let request: NSFetchRequest<Movie> = NSFetchRequest(entityName: String(describing: Movie.self))
        request.predicate = NSPredicate(format: "title like[cd] %@", title)
        return try managedObjectContext.fetch(request)
    }
    
    func saveTMDbApiConfiguration(_ configurationEntity: TMDbConfigurationEntity) throws {
        let configuration: TMDbApiConfiguration
        
        do {
            configuration = try getTMDbApiConfigurationEntity()
        } catch is PersistenceError {
            configuration = try createConfigurationEntity()
        }
        
        populate(configuration, with: configurationEntity)
        try managedObjectContext.save()
    }
    
    fileprivate func createConfigurationEntity() throws -> TMDbApiConfiguration {
        guard let newConfiguration = NSEntityDescription
            .entity(forEntityName: "TMDbApiConfiguration", in: managedObjectContext) else {
                throw PersistenceError.couldNotSaveObject
        }
        return TMDbApiConfiguration(entity: newConfiguration, insertInto: managedObjectContext)
    }
    
    fileprivate func populate(_ object: TMDbApiConfiguration, with entity: TMDbConfigurationEntity) {
        object.backdropSizes = entity.backdropSizes.map { $0.size }
        object.baseUrl = entity.baseUrl
        object.logoSizes = entity.logoSizes
        object.backdropSizes = entity.backdropSizes.map { $0.size }
        object.posterSizes = entity.posterSizes.map { $0.size }
        object.secureBaseUrl = entity.secureBaseUrl
        object.stillSizes = entity.stillSizes
        object.profileSizes = entity.profileSizes
        object.changeKeys = entity.changeKeys
    }
    
    func saveMovie(for movieEntity: MovieEntity) throws {
        let movie: Movie
        
        do {
            movie = try getMovie(with: movieEntity.id)
        } catch {
            movie = try createMovie()
            movie.remoteId = movieEntity.id
        }
        
        populate(movie, with: movieEntity)
        try managedObjectContext.save()
    }
    
    fileprivate func populate(_ object: Movie, with movieEntity: MovieEntity) {
        
        object.title = movieEntity.title
        object.overview = movieEntity.overview
        object.posterPath = movieEntity.posterPath
        object.backdropPath = movieEntity.backdropPath
        object.releaseDate = movieEntity.releaseDate
        object.originalTitle = movieEntity.originalTitle
        object.video = NSNumber(booleanLiteral: movieEntity.video)
        object.adult = NSNumber(booleanLiteral: movieEntity.adult)
        object.voteAverage = movieEntity.voteAverage
        object.popularity = movieEntity.popularity
        object.originalLanguage = movieEntity.originalLanguage
        object.favorite = NSNumber(booleanLiteral: movieEntity.favorite)
    }
    
    func getMovie(with id: Int) throws -> Movie {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.predicate = NSPredicate(format: "remoteId == %d", id)
        let fetchedObjectContext = try managedObjectContext.fetch(request)
        
        guard fetchedObjectContext.count == 1,
            let fetchedMovie = fetchedObjectContext.first else {
                throw PersistenceError.objectNotFound
        }
        
        return fetchedMovie
    }
    
    func getAllMovieEntities() throws -> [MovieEntity] {
        let movies = try getAllMovie()
        return movies.map { MovieEntity.fromLocalDataMovie($0) }
    }
    
    func getAllMovie() throws -> [Movie] {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        return try managedObjectContext.fetch(request)
    }
    
    fileprivate func createMovie() throws -> Movie {
        guard let newMovie = NSEntityDescription
            .entity(forEntityName: "Movie", in: managedObjectContext) else {
                throw PersistenceError.couldNotSaveObject
        }
        return Movie(entity: newMovie, insertInto: managedObjectContext)
    }
}

extension MovieEntity {
    static func fromLocalDataMovie(_ movie: Movie) -> MovieEntity {
        return MovieEntity(
            id: movie.remoteId ?? -1,
            title: movie.title ?? "",
            originalTitle: movie.originalTitle ?? "",
            adult: movie.adult?.boolValue ?? false,
            video: movie.video?.boolValue ?? false,
            releaseDate: movie.releaseDate ?? "",
            voteCount: Int(movie.voteCount ?? 0),
            backdropPath: movie.backdropPath ?? "",
            budget: 0,
            genres: [GenreEntity](),
            homepage: "",
            originalLanguage: movie.originalLanguage ?? "",
            overview: movie.overview ?? "",
            popularity: movie.popularity ?? 0,
            posterPath: movie.posterPath ?? "",
            revenue: 0,
            runtime: 0,
            status: "",
            tagline: movie.tagline ?? "",
            voteAverage: movie.voteAverage ?? 0,
            favorite: movie.favorite?.boolValue ?? false,
            posterUrl: movie.posterImageUrl ?? "",
            backdropUrl: movie.backdropImageUrl ?? "")
    }
}
