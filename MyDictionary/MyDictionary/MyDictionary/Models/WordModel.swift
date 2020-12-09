//
//  WordModel.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import CoreData

public final class WordModel {
        
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
