//
//  NSManagedObjectContext+Extension.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 28.01.2021.
//

import CoreData

extension NSManagedObjectContext {
    
    convenience init(model: NSManagedObjectModel, storeURL: URL) {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        try! persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        
        self.init(concurrencyType: .mainQueueConcurrencyType)
        
        self.persistentStoreCoordinator = persistentStoreCoordinator
    }
    
    func destroyStore() {
        persistentStoreCoordinator?.persistentStores.forEach {
            try? persistentStoreCoordinator?.remove($0)
            try? persistentStoreCoordinator?.destroyPersistentStore(at: $0.url!, ofType: $0.type, options: nil)
        }
    }
    
}
