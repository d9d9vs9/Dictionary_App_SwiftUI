//
//  WordDetailInteractor.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import Foundation

protocol WordDetailInteractor {
    
}

final class MYWordDetailInteractor: WordDetailInteractor {
    
    fileprivate let dataModel: WordDetailDataModel
    
    init(dataModel: WordDetailDataModel) {
        self.dataModel = dataModel
    }
    
}
