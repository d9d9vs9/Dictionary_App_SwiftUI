//
//  FetchWordProtocol.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 03.12.2020.
//

import Foundation

protocol FetchWordProtocol {
    func fetchWords(completionHandler: @escaping FetchResultWords)
    func fetchWord(byUUID uuid: String, completionHandler: @escaping ResultSavedWord)
}
