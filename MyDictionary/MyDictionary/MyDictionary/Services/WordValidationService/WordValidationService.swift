//
//  WordValidationService.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 09.12.2020.
//

import Foundation

public typealias WordValidationResult = ResultWithoutSuccessGeneric<Error>

protocol WordValidationService {
    func isValid(word: String, translatedWord: String) -> WordValidationResult
}

final class MYWordValidationService: WordValidationService {
    
}

extension MYWordValidationService {
    
    func isValid(word: String, translatedWord: String) -> WordValidationResult {
        let characterSet = NSCharacterSet.letters
        let wordRange = word.rangeOfCharacter(from: characterSet)
        let translatedWordRange = translatedWord.rangeOfCharacter(from: characterSet)
        var error: Error? {
            if (wordRange == nil) {
                return WordValidationError.wordInvalid
            }
            if (translatedWordRange == nil) {
                return WordValidationError.translatedWordInvalid
            }
            return nil
        }
        let isSuccess: Bool = (wordRange != nil && translatedWordRange != nil)
        if (isSuccess) {
            return .success
        } else {
            return .failure(error!)
        }
    }
    
}
