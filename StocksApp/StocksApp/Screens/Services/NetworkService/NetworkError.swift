//
//  NetworkError.swift
//  StocksApp
//
//  Created by Bauyrzhan Abdi on 26.05.2022.
//

import Foundation

enum NetworkError: String, Error {
    case missingURL
    case missingRequest
    case taskError
    case responseError
    case dataError
    case decodeError
}
