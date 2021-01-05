//
//  Encodable+Extension.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 05.01.2021.
//

import Foundation

extension Encodable {
    
    var data: Data? {
        return try? JSONEncoder().encode(self)
    }
    
}
