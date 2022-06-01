//
//  DetailsResponse.swift
//  StocksApp
//
//  Created by Bauyrzhan Abdi on 31.05.2022.
//

import Foundation

struct Chart : Decodable {
    let prices : [[Double]]
    let marketCaps : [[Double]]
    let totalVolumes : [[Double]]
    
    enum CodingKeys : String, CodingKey {
        case prices
        case marketCaps = "market_caps"
        case totalVolumes = "total_volumes"
    }
}
