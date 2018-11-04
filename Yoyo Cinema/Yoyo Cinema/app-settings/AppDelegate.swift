//
//  AppDelegate.swift
//  Yoyo Cinema
//
//  Created by Amadeu Cavalcante Filho on 02/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        PersistentContainerFactory.make().viewContext
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarController = MovieTabBarController()
        
        let searchView: UIViewController = SearchMovieWireFrame.createSearchMovieModule() as! UIViewController
        let favoriteView: UIViewController = FavoriteWireFrame.createFavoriteMovieModule() as! UIViewController
        
        tabBarController.viewControllers = [searchView, favoriteView]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = PersistentContainerFactory.make().viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

