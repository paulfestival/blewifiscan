//
//  CoreDataManager.swift
//  BleWifiScan
//
//  Created by Pavel Mac on 10/16/25.
//

import UIKit
import CoreData

class CoreDataManager {
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BleWifiScan")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    static var backgroundContext: NSManagedObjectContext = {
        return CoreDataManager.persistentContainer.newBackgroundContext()
    }()
    
    init() {
    }
}
