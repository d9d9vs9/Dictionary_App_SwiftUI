//
//  String+Extension.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 03.12.2020.
//

import Foundation

extension String {
    
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
    
    func localized(with variable: CVarArg, comment: String = "") -> String {
        return String(format: localized(comment: comment), [variable])
    }
    
    func localized(lang: String, tableName: String) -> String {
        let path = Bundle.main.path(forResource: lang, ofType: "lproj") ?? ""
        if let bundle = Bundle(path: path) {
            return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: "**\(self)**", comment: "")
        } else {
            return ""
        }
    }
    
    func localized(tableName: String) -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
    
}
