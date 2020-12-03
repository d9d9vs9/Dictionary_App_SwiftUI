//
//  AddWordDataModel.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 03.12.2020.
//

import Foundation

final class AddWordDataModel {
    
    /// Defauilt is Constants.StaticText.emptyString
    @Published var wordText: String
    
    init() {
        self.wordText = Constants.StaticText.emptyString
    }
    
}
