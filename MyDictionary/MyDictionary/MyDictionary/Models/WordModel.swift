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
    let translate: String
    let createdDate: Date
    
    init(id: String = UUID().uuidString,
         word: String,
         translate: String,
         createdDate: Date) {
        
        self.id = id
        self.word = word
        self.translate = translate
        self.createdDate = createdDate
        
    }
    
}

extension WordModel: Identifiable {}

extension WordModel: ObservableObject {}

extension WordModel: Equatable {
    
    static func == (lhs: WordModel, rhs: WordModel) -> Bool {
        return lhs.id == rhs.id
    }
    
}

extension WordModel {
    
    static var mock: [WordModel] {
        return [.init(word: "Help",
                      translate: "Помощь",
                      createdDate: Date.init())]
    }
    
}
