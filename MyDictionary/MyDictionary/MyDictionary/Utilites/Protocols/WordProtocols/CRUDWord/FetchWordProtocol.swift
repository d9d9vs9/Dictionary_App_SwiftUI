//
//  FetchWordProtocol.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 03.12.2020.
//

import Foundation

protocol FetchWordProtocol {
    func fetchWords() -> [WordModel]
}
