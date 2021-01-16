//
//  GetWordModel.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 16.01.2021.
//

import Foundation

struct GetWordModel: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case limit
        case offset
    }
    
    let limit: Int
    let offset: Int
    
    init(limit: Int,
         offset: Int) {
        
        self.limit = limit
        self.offset = offset
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(limit, forKey: .limit)
        try container.encode(offset, forKey: .offset)
    }
    
}
