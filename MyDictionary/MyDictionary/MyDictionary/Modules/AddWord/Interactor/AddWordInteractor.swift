//
//  AddWordInteractor.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 03.12.2020.
//

import Foundation

protocol AddWordInteractor {
    var dataModel: AddWordDataModel { get }
}

final class MYAddWordInteractor: AddWordInteractor {

    let dataModel: AddWordDataModel
    
    init(dataModel: AddWordDataModel) {
        self.dataModel = dataModel
    }
    
}
