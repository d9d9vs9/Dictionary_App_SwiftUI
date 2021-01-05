//
//  WordModel.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import CoreData

public final class WordModel: Codable {
        
    enum CodingKeys: String, CodingKey {
        case uuid
        case word
        case translatedWord = "translated_word"
        case createdDate = "created_date"
    }
    
    let uuid: String
    let word: String
    let translatedWord: String
    let stringCreatedDate: String
    var createdDate: Date {
        return ISO8601DateFormatter.init().date(from: stringCreatedDate)!
    }
    
    init(uuid: String,
         word: String,
         translatedWord: String,
         stringCreatedDate: String) {
         
        self.uuid = uuid
        self.word = word
        self.translatedWord = translatedWord
        self.stringCreatedDate = stringCreatedDate
        
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uuid = try container.decode(String.self, forKey: .uuid)
        self.word = try container.decode(String.self, forKey: .word)
        self.translatedWord = try container.decode(String.self, forKey: .translatedWord)
        self.stringCreatedDate = try container.decode(String.self, forKey: .createdDate)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uuid, forKey: .uuid)
        try container.encode(word, forKey: .word)
        try container.encode(translatedWord, forKey: .translatedWord)
        try container.encode(stringCreatedDate, forKey: .createdDate)
    }
    
}

extension WordModel: Identifiable {}

extension WordModel: ObservableObject {}

extension WordModel {
    
    func word(insertIntoManagedObjectContext: NSManagedObjectContext) -> Word {
        return Word.init(uuid: uuid,
                         word: word,
                         translatedWord: translatedWord,
                         stringCreatedDate: stringCreatedDate,
                         insertIntoManagedObjectContext: insertIntoManagedObjectContext)
    }
    
}
