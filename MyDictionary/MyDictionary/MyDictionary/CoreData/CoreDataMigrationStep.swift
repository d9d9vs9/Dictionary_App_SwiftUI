//
//  CoreDataMigrationStep.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 28.01.2021.
//

import CoreData

struct CoreDataMigrationStep {
    
    let sourceModel: NSManagedObjectModel
    let destinationModel: NSManagedObjectModel
    let mappingModel: NSMappingModel
    
    init(sourceVersion: CoreDataMigrationVersion, destinationVersion: CoreDataMigrationVersion) {
        
        let sourceModel = NSManagedObjectModel.managedObjectModel(forResource: sourceVersion.stringVersion)
        let destinationModel = NSManagedObjectModel.managedObjectModel(forResource: destinationVersion.stringVersion)
        guard let mappingModel = CoreDataMigrationStep.mappingModel(fromSourceModel: sourceModel,
                                                                    toDestinationModel: destinationModel) else {
            fatalError("Expected modal mapping not present")
        }
        
        self.sourceModel = sourceModel
        self.destinationModel = destinationModel
        self.mappingModel = mappingModel
    }
    
}

fileprivate extension CoreDataMigrationStep {
    
    static func mappingModel(fromSourceModel sourceModel: NSManagedObjectModel,
                             toDestinationModel destinationModel: NSManagedObjectModel) -> NSMappingModel? {
        guard let customMapping = customMappingModel(fromSourceModel: sourceModel, toDestinationModel: destinationModel) else {
            return inferredMappingModel(fromSourceModel:sourceModel, toDestinationModel: destinationModel)
        }
        
        return customMapping
    }
    
    static func inferredMappingModel(fromSourceModel sourceModel: NSManagedObjectModel,
                                     toDestinationModel destinationModel: NSManagedObjectModel) -> NSMappingModel? {
        return try? NSMappingModel.inferredMappingModel(forSourceModel: sourceModel, destinationModel: destinationModel)
    }
    
    static func customMappingModel(fromSourceModel sourceModel: NSManagedObjectModel,
                                   toDestinationModel destinationModel: NSManagedObjectModel) -> NSMappingModel? {
        return NSMappingModel(from: [Bundle.main], forSourceModel: sourceModel, destinationModel: destinationModel)
    }
    
}
