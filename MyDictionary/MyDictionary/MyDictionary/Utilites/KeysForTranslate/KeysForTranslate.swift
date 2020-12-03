//
//  KeysForTranslate.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 03.12.2020.
//

import Foundation

enum KeysForTranslate: String {    
    case words
    case pleaseEnterWord = "please_enter_word"
    case addToMyDictionary = "add_to_my_dictionary"
    case pleaseEnterTranslate = "please_enter_translate"
}

// MARK: - LocalizableProtocol
extension KeysForTranslate: LocalizableProtocol {
    
    /// Default is Constants.StaticText.defaultTableName
    var tableName: String {
        return Constants.StaticText.defaultTableName
    }
    
}
