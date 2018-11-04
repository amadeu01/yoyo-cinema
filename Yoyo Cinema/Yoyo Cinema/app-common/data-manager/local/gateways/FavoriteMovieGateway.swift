//
//  FavoriteMovieGateway.swift
//  Yoyo Cinema
//
//  Created by Amadeu Cavalcante Filho on 04/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation
import CoreData

public final class FavoriteMovieGateway: FavoriteMovieLocalGatewayProtocol {
    let localDataManager = MovieLocalDataManager(managedObjectContext: CoreDataStore.managedObjectContext)
    
    public func isMovieFavorited(_ movie: MovieEntity) -> Bool {
        return retriveAllFavoriteMovies().first(where: { $0.id == movie.id }) != nil
    }
    
    public func retriveAllFavoriteMovies() -> [MovieEntity] {
        do {
            let movies = try localDataManager.getAllMovieEntities()
            return movies.filter { $0.favorite == true }
        } catch {
            return [MovieEntity]()
        }
    }
    
    public func favorite(movie: MovieEntity) {
        try! localDataManager.saveMovie(for: movie.favorited())
    }
    
}
