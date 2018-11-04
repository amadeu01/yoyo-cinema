//
//  CoreDataStore.swift
//  Yoyo Cinema
//
//  Created by Amadeu Cavalcante Filho on 02/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

class CoreDataStore {
    static var persistentStoreCoordinator = PersistenceStoreCoordinatorFactory.make()
    
    static var managedObjectModel = ManagedObjectModelFactory.make()
    
    static var managedObjectContext = ManagedObjectContextFactory.make()
}
