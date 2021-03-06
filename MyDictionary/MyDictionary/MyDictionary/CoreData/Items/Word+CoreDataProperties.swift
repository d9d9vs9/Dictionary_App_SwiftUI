//
//  Word+CoreDataProperties.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 04.12.2020.
//
//

import Foundation
import CoreData

struct WordAttributeName {
    static let uuid: String = "uuid"
    static let word: String = "word"
    static let translatedWord: String = "translatedWord"
    static let stringCreatedDate: String = "stringCreatedDate"
}

extension Word {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Word> {
        return NSFetchRequest<Word>(entityName: CoreDataEntityName.word)
    }

    @NSManaged public var uuid: String
    @NSManaged public var word: String
    @NSManaged public var translatedWord: String
    @NSManaged public var stringCreatedDate: String
        
}

extension Word : Identifiable {

}

extension Word {
    
    var wordModel: WordModel {
        return WordModel.init(uuid: uuid, word: word, translatedWord: translatedWord, stringCreatedDate: stringCreatedDate)
    }
    
}
