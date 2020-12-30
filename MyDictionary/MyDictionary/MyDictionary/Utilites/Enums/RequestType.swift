//
//  RequestType.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 30.12.2020.
//

import Foundation

enum RequestType {
    /// Will translate to a URLSessionDataTask.
    case data
    /// Will translate to a URLSessionDownloadTask.
    case download
    /// Will translate to a URLSessionUploadTask.
    case upload
}
