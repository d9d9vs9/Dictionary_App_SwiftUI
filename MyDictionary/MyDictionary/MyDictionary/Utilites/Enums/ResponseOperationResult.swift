//
//  ResponseOperationResult.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 30.12.2020.
//

import Foundation

enum ResponseOperationResult {
    case data(_ : Data, _ : HTTPURLResponse?)
    case error(_ : Error, _ : HTTPURLResponse?)
}
