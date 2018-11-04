//
//  PersistenceFactory.swift
//  Yoyo Cinema
//
//  Created by Amadeu Cavalcante Filho on 02/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import CoreData

final class PersistenceStoreCoordinatorFactory {
    static func make() -> NSPersistentStoreCoordinator {
        return PersistentContainerFactory.make().persistentStoreCoordinator
    }
}

final class ManagedObjectContextFactory {
    static func make() -> NSManagedObjectContext {
        return PersistentContainerFactory.make().viewContext
    }
}

final class ManagedObjectModelFactory {
    static func make() -> NSManagedObjectModel {
        return PersistentContainerFactory.make().managedObjectModel
    }
}

public final class PersistentContainerFactory {
    fileprivate static let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Yoyo_Cinema")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    public static func make() -> NSPersistentContainer {
        return persistentContainer
    }
}
