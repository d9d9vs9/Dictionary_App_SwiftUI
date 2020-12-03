//
//  LocalizableProtocol.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 03.12.2020.
//

import Foundation

protocol LocalizableProtocol {
    var tableName: String { get }
    var localized: String { get }
}

extension LocalizableProtocol where Self: RawRepresentable, Self.RawValue == String {
            
    func localized(lang: AppLanguageType, tableName: String) -> String {
        return rawValue.localized(lang: lang.rawValue, tableName: tableName)
    }
    
    /// - Parameter lang:  MYAppLanguageService.shared.appLanguage.rawValue
    /// - Parameter tableName: Constants.StaticText.defaultTableName
    var localized: String {
        return rawValue.localized(lang: MYAppLanguageService.shared.appLanguage.rawValue,
                                  tableName: Constants.StaticText.defaultTableName)
    }
    
}
