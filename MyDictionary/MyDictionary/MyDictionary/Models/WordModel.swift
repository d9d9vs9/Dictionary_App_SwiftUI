//
//  WordModel.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import Foundation

public final class WordModel {
    
    /// UUID
    public let id: String
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
