//
//  StocksService.swift
//  StocksApp
//
//  Created by Bauyrzhan Abdi on 27.05.2022.
//

import Foundation

protocol StocksServiceProtocol {
    func getStocks(currency : String, count : String, completion : @escaping (Result<[Stock], NetworkError>) -> Void)
    func getStocks(currency : String, completion : @escaping (Result<[Stock], NetworkError>) -> Void)
    func getStocks(completion : @escaping (Result<[Stock], NetworkError>) -> Void)
    
    func getDetails(id : String, currency : String, days : String, interval : String, completion : @escaping (Result<Chart, NetworkError>) -> Void)
    func getDetails(id : String, currency : String, days : String, completion : @escaping (Result<Chart, NetworkError>) -> Void)
    func getDetails(id : String, currency : String, completion : @escaping (Result<Chart, NetworkError>) -> Void)
    func getDetails(id : String, completion : @escaping (Result<Chart, NetworkError>) -> Void)
}

extension StocksServiceProtocol {
    
    func getStocks(currency : String, completion : @escaping (Result<[Stock], NetworkError>) -> Void) {
        getStocks(currency: currency, count: "100", completion: completion)
    }
    
    func getStocks(completion : @escaping (Result<[Stock], NetworkError>) -> Void) {
        getStocks(currency: "usd", completion: completion)
    }
    
    
    func getDetails(id: String, currency : String, days: String, completion: @escaping (Result<Chart, NetworkError>) -> Void) {
        getDetails(id: id, currency : currency, days: days, interval: "daily", completion: completion)
    }
    
    func getDetails(id: String, currency : String, completion: @escaping (Result<Chart, NetworkError>) -> Void) {
        getDetails(id: id, currency : currency, days: "600", completion: completion)
    }
    
    func getDetails(id : String, completion : @escaping (Result<Chart, NetworkError>) -> Void) {
        getDetails(id: id, currency: "usd", completion: completion)
    }
}

final class StocksService : StocksServiceProtocol {
    
    private let client : NetworkService
    
    init(client: NetworkService) {
        self.client = client
    }
    
    func getStocks(currency : String, count : String, completion : @escaping (Result<[Stock], NetworkError>) -> Void) {
        client.execute(with: StocksRouter.stocks(currency: currency, count: count), completion: completion)
    }
    
    func getDetails(id: String, currency : String, days: String, interval: String, completion: @escaping (Result<Chart, NetworkError>) -> Void) {
        client.execute(with: StocksRouter.details(id: id, currency: currency, days: days, interval: interval), completion: completion)
    }    
}
