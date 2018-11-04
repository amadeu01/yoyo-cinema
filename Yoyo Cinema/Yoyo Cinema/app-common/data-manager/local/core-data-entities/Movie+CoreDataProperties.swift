//
//  Movie+CoreDataProperties.swift
//  Yoyo Cinema
//
//  Created by Amadeu Cavalcante Filho on 02/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import CoreData

extension Movie {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }
    
    @NSManaged public var video: NSNumber?
    @NSManaged public var favorite: NSNumber?
    @NSManaged public var title: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var originalLanguage: String?
    @NSManaged public var originalTitle: String?
    @NSManaged public var genreIds: [NSNumber]
    @NSManaged public var backdropPath: String?
    @NSManaged public var adult: NSNumber?
    @NSManaged public var overview: String?
    @NSManaged public var posterImageUrl: String?
    @NSManaged public var backdropImageUrl: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var tagline: String?
    
    public var voteCount: Int32? {
        get {
            willAccessValue(forKey: "voteCount")
            defer { didAccessValue(forKey: "voteCount") }
            
            return primitiveValue(forKey: "voteCount") as? Int32
        }
        set {
            willChangeValue(forKey: "voteCount")
            defer { didChangeValue(forKey: "voteCount") }
            
            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "voteCount")
                return
            }
            setPrimitiveValue(value, forKey: "voteCount")
        }
    }
    
    public var remoteId: Int? {
        get {
            willAccessValue(forKey: "remoteId")
            defer { didAccessValue(forKey: "remoteId") }
            
            return primitiveValue(forKey: "remoteId") as? Int
        }
        set {
            willChangeValue(forKey: "remoteId")
            defer { didChangeValue(forKey: "remoteId") }
            
            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "remoteId")
                return
            }
            setPrimitiveValue(value, forKey: "remoteId")
        }
    }
    
    public var voteAverage: Double? {
        get {
            willAccessValue(forKey: "voteAverage")
            defer { didAccessValue(forKey: "voteAverage") }
            
            return primitiveValue(forKey: "voteAverage") as? Double
        }
        set {
            willChangeValue(forKey: "voteAverage")
            defer { didChangeValue(forKey: "voteAverage") }
            
            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "voteAverage")
                return
            }
            setPrimitiveValue(value, forKey: "voteAverage")
        }
    }
    
    public var popularity: Double? {
        get {
            willAccessValue(forKey: "popularity")
            defer { didAccessValue(forKey: "popularity") }
            
            return primitiveValue(forKey: "popularity") as? Double
        }
        set {
            willChangeValue(forKey: "popularity")
            defer { didChangeValue(forKey: "popularity") }
            
            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "popularity")
                return
            }
            setPrimitiveValue(value, forKey: "popularity")
        }
    }
}
