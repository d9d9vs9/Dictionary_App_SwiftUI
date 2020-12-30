//
//  EnvironmentProtocol.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 30.12.2020.
//

import Foundation

protocol EnvironmentProtocol {
    var httpHeaders: HTTPHeader? { get }
    var baseURL: String { get }
}
