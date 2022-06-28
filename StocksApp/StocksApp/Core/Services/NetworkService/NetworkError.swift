//
//  NetworkError.swift
//  StocksApp
//
//  Created by Bauyrzhan Abdi on 27.05.2022.
//

import Foundation

enum NetworkError: String, Error {
    case missingURL = "URL is missing"
    case missingRequest = "Request is missing"
    case taskError = "Data task can not be loaded"
    case responseError = "Response can not be loaded"
    case dataError = "Data can not be loaded"
    case decodeError = "Request can not be decoded"
}
