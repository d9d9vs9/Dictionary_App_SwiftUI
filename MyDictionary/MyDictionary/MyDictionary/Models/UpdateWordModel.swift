//
//  UpdateWordModel.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 06.01.2021.
//

import Foundation

struct UpdateWordModel: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case word
        case translatedWord = "translated_word"
    }
    
    let uuid: String
    let word: String
    let translatedWord: String
    
    init(uuid: String, word: String, translatedWord: String) {
        self.uuid = uuid
        self.word = word
        self.translatedWord = translatedWord
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uuid, forKey: .uuid)
        try container.encode(word, forKey: .word)
        try container.encode(translatedWord, forKey: .translatedWord)
    }
    
}
