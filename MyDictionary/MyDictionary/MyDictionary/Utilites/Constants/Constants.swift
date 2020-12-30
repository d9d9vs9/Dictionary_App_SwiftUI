//
//  Constants.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 03.12.2020.
//

import Foundation

struct Constants {
    
    struct StaticText {
        static let emptyString: String = ""
        static let defaultTableName: String = "Localizable"
        static let appName: String = "MyDictionary"
        static let momdExtension: String = "momd"
    }
    
    struct CoreData {
        static let fetchLimit: Int = 10
    }
    
    struct HTTPHeaderConstants {
        
        static let contentType: String = "Content-Type"
        static let applicationJson: String = "application/json"
        
        /// return
        /// Content-Type : application/json        
        static func defaultHeaders() -> HTTPHeader {
            return [contentType : applicationJson]
        }
        
    }

}
