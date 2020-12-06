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
    
    convenience init(id: String, word: String, translatedWord: String, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        let entity = NSEntityDescription.entity(forEntityName: CoreDataEntityName.word, in: context)!
        self.init(entity: entity, insertInto: context)
        self.id = id
        self.word = word
        self.translatedWord = translatedWord
    }
    
}
