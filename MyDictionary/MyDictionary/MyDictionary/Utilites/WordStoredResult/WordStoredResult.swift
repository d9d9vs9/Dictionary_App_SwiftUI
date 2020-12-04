//
//  WordStoredResult.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 03.12.2020.
//

import Foundation

public typealias WordStoredResult = ResultSaved
public typealias ResultSavedWord = ((Result<WordModel, Error>) -> Void)
public typealias ResultSaved = ((ResultSavedData<Error>) -> Void)
public typealias FetchResultWords = ((Result<[WordModel],Error>) -> Void)

public enum ResultSavedData<Failure> where Failure : Error {
    case success
    case failure(Failure)
}
