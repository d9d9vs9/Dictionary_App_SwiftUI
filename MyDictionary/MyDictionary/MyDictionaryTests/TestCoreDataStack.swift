//
//  TestCoreDataStack.swift
//  MyDictionaryTests
//
//  Created by Дмитрий Чумаков on 04.12.2020.
//

import Foundation
import CoreData
@testable import MyDictionary

class TestCoreDataStack: CoreDataStack {
    
    override init() {
        super.init()
        
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        let container = NSPersistentContainer(
            name: Constants.StaticText.appName,
            managedObjectModel: CoreDataStack.model)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        storeContainer = container
        
    }
    
}
