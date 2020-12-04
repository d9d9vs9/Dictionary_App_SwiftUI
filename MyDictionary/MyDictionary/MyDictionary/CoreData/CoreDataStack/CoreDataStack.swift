//
//  CoreDataStack.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import CoreData

open class CoreDataStack {
    
    public static let model: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: Constants.StaticText.appName,
                                       withExtension: Constants.StaticText.momdExtension)!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    public init() {
    }
    
    public lazy var mainContext: NSManagedObjectContext = {
        return storeContainer.viewContext
    }()
    
    public lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.StaticText.appName,
                                              managedObjectModel: CoreDataStack.model)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
}

// MARK: - Save Context
extension CoreDataStack {
    
    public func saveMainContext(completionHandler: @escaping ResultSaved) {
        saveContext(mainContext, completionHandler: completionHandler)
    }
    
    public func saveContext(_ context: NSManagedObjectContext, completionHandler: @escaping ResultSaved) {
        context.perform {
            do {
                try context.save()
                completionHandler(.success)
            } catch {
                let nsError = error as NSError
                debugPrint(#function, "Unresolved error \(nsError), \(nsError.userInfo)")
                completionHandler(.failure(error))
            }
        }
    }
    
}
