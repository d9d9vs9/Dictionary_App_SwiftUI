//
//  CoreDataMigrationVersion.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 28.01.2021.
//

import Foundation

enum CoreDataMigrationVersion: Int, CaseIterable {
    
    case version1 = 1
    case version2
        
    var stringVersion: String {
        if rawValue == 1 {
            return Constants.StaticText.appName
        } else {
            return "\(Constants.StaticText.appName) \(rawValue)"
        }
    }
    
    static var current: CoreDataMigrationVersion {
        guard let current = allCases.last else {
            fatalError("no model versions found")
        }
        return current
    }

    func nextVersion() -> CoreDataMigrationVersion? {
        switch self {
        case .version1:
            return .version2
        case .version2:
            return nil
        }
    }
    
}
