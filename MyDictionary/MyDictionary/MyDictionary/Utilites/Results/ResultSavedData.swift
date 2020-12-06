//
//  ResultSavedData.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 06.12.2020.
//

import Foundation

public enum ResultSavedData<Failure> where Failure : Error {
    case success
    case failure(Failure)
}
