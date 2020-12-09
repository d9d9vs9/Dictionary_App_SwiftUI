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
    case edit = "edit"
    case cancel
    case search
    case word
    case translatedWord = "translated_Word"
    case done
    case error
    case fieldWordInvalid = "field_Word_Invalid"
    case fieldTranslatedWordInvalid = "field_Translated_Word_Invalid"
}

// MARK: - LocalizableProtocol
extension KeysForTranslate: LocalizableProtocol {
    
    /// Default is Constants.StaticText.defaultTableName
    var tableName: String {
        return Constants.StaticText.defaultTableName
    }
    
}
