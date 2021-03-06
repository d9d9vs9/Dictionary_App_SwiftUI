//
//  Word+CoreDataClass.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 04.12.2020.
//
//

import Foundation
import CoreData

@objc(Word)
public class Word: NSManagedObject {
    
    convenience init(uuid: String,
                     word: String,
                     translatedWord: String,
                     stringCreatedDate: String,
                     insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        let entity = NSEntityDescription.entity(forEntityName: CoreDataEntityName.word, in: context)!
        self.init(entity: entity, insertInto: context)
        self.uuid = uuid
        self.word = word
        self.translatedWord = translatedWord
        self.stringCreatedDate = stringCreatedDate
    }
    
}
