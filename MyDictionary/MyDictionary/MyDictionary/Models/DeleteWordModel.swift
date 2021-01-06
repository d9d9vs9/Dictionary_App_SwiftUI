//
//  DeleteWordModel.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 06.01.2021.
//

import Foundation

struct DeleteWordModel: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case uuid
    }
    
    let uuid: String
    
    init(uuid: String) {
        self.uuid = uuid
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uuid, forKey: .uuid)
    }
    
}
