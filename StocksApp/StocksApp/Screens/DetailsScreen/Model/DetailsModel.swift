//
//  DetailsModel.swift
//  StocksApp
//
//  Created by Bauyrzhan Abdi on 31.05.2022.
//

import Foundation
import UIKit

protocol DetailsModelProtocol {
    var prices : [[Double]] {get}
    var caps : [[Double]] {get}
    var volumes : [[Double]] {get}
}

final class DetailsModel : DetailsModelProtocol {
    private let detail : Chart
    
    init(detail: Chart) {
        self.detail = detail
    }
    
    var prices: [[Double]] {
        detail.prices
    }
    
    var caps: [[Double]] {
        detail.marketCaps
    }
    
    var volumes : [[Double]] {
        detail.totalVolumes
    }
    
}
