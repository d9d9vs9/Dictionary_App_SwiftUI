//
//  WordListInteractor.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import Foundation

protocol WordListInteractor {
    var dataModel: WordListDataModel { get }
}

final class MYWordListInteractor: WordListInteractor {
    
    let dataModel: WordListDataModel
    
    init(dataModel: WordListDataModel) {
        self.dataModel = dataModel
    }
    
}
