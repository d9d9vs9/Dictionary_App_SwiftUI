//
//  WordModel.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import Foundation

final class WordModel {
    
    let id: String
    let word: String
    let translatedWord: String
    
    init(id: String,
         word: String,
         translatedWord: String) {
        
        self.id = id
        self.word = word
        self.translatedWord = translatedWord
        
    }
    
}

extension WordModel: Identifiable {}

extension WordModel: ObservableObject {}

extension WordModel: Equatable {
    
    static func == (lhs: WordModel, rhs: WordModel) -> Bool {
        return lhs.id == rhs.id
    }
    
}
