//
//  WordModel.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import Foundation

public final class WordModel {
        
    let uuid: String
    let word: String
    let translatedWord: String
    
    init(uuid: String,
         word: String,
         translatedWord: String) {
         
        self.uuid = uuid
        self.word = word
        self.translatedWord = translatedWord
        
    }
    
}

extension WordModel: Identifiable {}

extension WordModel: ObservableObject {}
