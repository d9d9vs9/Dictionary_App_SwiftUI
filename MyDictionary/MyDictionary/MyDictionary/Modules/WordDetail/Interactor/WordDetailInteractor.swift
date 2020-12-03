//
//  WordDetailInteractor.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import Foundation

protocol WordDetailInteractor {
    var dataModel: WordDetailDataModel { get }
}

final class MYWordDetailInteractor: WordDetailInteractor {
    
    let dataModel: WordDetailDataModel
    
    init(dataModel: WordDetailDataModel) {
        self.dataModel = dataModel
    }
    
}
