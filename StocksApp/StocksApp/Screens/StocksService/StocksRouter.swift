//
//  StocksRouter.swift
//  StocksApp
//
//  Created by Bauyrzhan Abdi on 30.05.2022.
//

import Foundation

enum StocksRouter : Router {
    case stocks(currency : String, count : String)
    case details(id : String, currency : String, days : String, interval : String)
    
    var baseUrl: String {
        "https://api.coingecko.com"
    }
    
    var path: String {
        switch self {
        case .stocks:
            return "/api/v3/coins/markets"
        case .details(let id, _, _, _):
            return "/api/v3/coins/\(id)/market_chart"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .stocks, .details:
            return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .stocks(let currency, let count):
            return ["vs_currency" : currency, "per_page" : count]
        case .details(_, let currency, let days, let interval):
            return ["vs_currency" : currency, "days" : days, "interval" : interval]
        }
    }
}
