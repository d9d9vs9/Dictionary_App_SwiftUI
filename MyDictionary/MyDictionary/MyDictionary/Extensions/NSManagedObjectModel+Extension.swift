//
//  NSManagedObjectModel+Extension.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 28.01.2021.
//

import CoreData

extension NSManagedObjectModel {

    static func managedObjectModel(forResource resource: String) -> NSManagedObjectModel {
        let mainBundle = Bundle.main
        let subdirectory = Constants.StaticText.appName + Constants.StaticText.dot + Constants.StaticText.momdExtension
        let omoURL = mainBundle.url(forResource: resource, withExtension: Constants.StaticText.omoExtension, subdirectory: subdirectory) // optimised model file
        let momURL = mainBundle.url(forResource: resource, withExtension: Constants.StaticText.momExtension, subdirectory: subdirectory)

        guard let url = omoURL ?? momURL else {
            fatalError("unable to find model in bundle")
        }

        guard let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError("unable to load model in bundle")
        }

        return model
    }
    
}
