//
//  AppLanguageService.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 03.12.2020.
//

import Foundation

protocol AppLanguageService {
    var appLanguage: AppLanguageType { get }
    func setAppLanguage(_ newAppLanguage: AppLanguageType)
}

struct MYAppLanguageService: AppLanguageService {
    
    fileprivate let appleLanguagesKey: String = "AppleLanguages"
    /// Default is .en
    fileprivate let defaultAppLanguage: AppLanguageType = .en
    /// Default is .current
    fileprivate let locale: Locale
    /// Default is Local.current.languageCode
    fileprivate var languageCode: String? {
        return locale.languageCode
    }
    
    var appLanguage: AppLanguageType {
        
        guard let lanCode = self.languageCode else { return .uk }
        let stringFromAppleKey = getLanguageStringFromAppleLanguagesKey()
        
        if (stringFromAppleKey == nil) {
            return defaultAppLanguage
        } else {
            let appLanguage = AppLanguageType.allCases.first(where: { $0.rawValue == stringFromAppleKey! })
            if (appLanguage == nil) {
                guard let lang = AppLanguageType.init(rawValue: lanCode) else { return defaultAppLanguage }
                return lang
            } else {
                return appLanguage!
            }
        }
        
    }
    
    static let shared: AppLanguageService = MYAppLanguageService.init(locale: .current)
    
    fileprivate init(locale: Locale) {
        self.locale = locale
    }
    
}

// MARK: - Set App Language
extension MYAppLanguageService {
    
    func setAppLanguage(_ newAppLanguage: AppLanguageType) {
        UserDefaults.standard.set([newAppLanguage.rawValue], forKey: appleLanguagesKey)
        UserDefaults.standard.synchronize()
    }
    
}

// MARK: - Get Language String From Apple Languages Key
fileprivate extension MYAppLanguageService {
    
    func getLanguageStringFromAppleLanguagesKey() -> String? {
        return (UserDefaults.standard.object(forKey: appleLanguagesKey) as? [String])?.first
    }
    
}
