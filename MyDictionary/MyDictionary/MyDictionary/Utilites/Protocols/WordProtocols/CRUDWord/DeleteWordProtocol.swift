//
//  DeleteWordProtocol.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 03.12.2020.
//

import Foundation

protocol DeleteWordProtocol {
    func delete(byID id: String, completionHandler: @escaping ResultDeletedWord)
}
