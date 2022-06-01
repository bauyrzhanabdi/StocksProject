//
//  StocksModel.swift
//  StocksApp
//
//  Created by Bauyrzhan Abdi on 30.05.2022.
//

import Foundation
import UIKit

protocol StocksModelProtocol {
    var id : String {get}
    var name : String {get}
    var symbol : String {get}
    var iconUrl : String {get}
    var price : String {get}
    var change : String {get}
    var changeColor : UIColor {get}
    var isFavourite : Bool {get set}
    
    func setFavorite()
}

final class StocksModel : StocksModelProtocol {
    private let stock : Stock
    private let favoritesService : FavoritesServiceProtocol
    
    init(stock: Stock) {
        self.stock = stock
        favoritesService = ModuleBuilder.shared.favoritesService
        isFavourite = favoritesService.isFavorite(for: id)
    }
    
    var id: String {
        stock.id
    }
    
    var name: String {
        stock.name
    }
    
    var symbol: String {
        stock.symbol.uppercased()
    }
    
    var iconUrl: String {
        stock.image
    }
    
    var price: String {
        String(format: "%.2f$", stock.price)
    }
    
    var change: String {
        String(format: "%.2f$ ", stock.change) + String(format: "(%.2f%%)", stock.percentage)
    }
    
    var changeColor: UIColor {
        stock.change >= 0 ? .green : .red
    }
    
    var isFavourite: Bool = false
    
    func setFavorite() {
        isFavourite.toggle()
        
        if isFavourite {
            favoritesService.save(stock: stock)
        } else {
            favoritesService.remove(stock: stock)
        }
    }
}
