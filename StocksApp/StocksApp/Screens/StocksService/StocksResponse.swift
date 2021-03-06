//
//  StocksResponse.swift
//  StocksApp
//
//  Created by Bauyrzhan Abdi on 30.05.2022.
//

import Foundation

struct Stock : Codable {
    let id : String
    let symbol : String
    let name : String
    let image : String
    let price : Double
    let change : Double
    let percentage : Double

    enum CodingKeys : String, CodingKey {
        case id, symbol, name, image
        case price = "current_price"
        case change = "price_change_24h"
        case percentage = "price_change_percentage_24h"
    }
}
