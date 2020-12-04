//
//  WordModel.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import Foundation

final class WordModel {
        
    let word: String
    let translatedWord: String
    
    init(word: String,
         translatedWord: String) {
                
        self.word = word
        self.translatedWord = translatedWord
        
    }
    
}

extension WordModel: Identifiable {}

extension WordModel: ObservableObject {}

extension WordModel: Equatable {
    
    static func == (lhs: WordModel, rhs: WordModel) -> Bool {
        return lhs.word == rhs.word && lhs.translatedWord == rhs.translatedWord
    }
    
}

extension WordModel {
    
    var wordModelCD: Word {
        let word: Word = .init(word: self.word,
                               translatedWord: self.translatedWord,
                               insertIntoManagedObjectContext: CoreDataStack.shared.viewContext)
        return word
    }
    
}

extension Word {
    
    var wordModel: WordModel {
        guard let word = self.word, let translatedWord = self.translatedWord else { fatalError("Can't Find Object") }
        return WordModel.init(word: word, translatedWord: translatedWord)
    }
    
}
