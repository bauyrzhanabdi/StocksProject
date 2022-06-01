//
//  FavoritesModel.swift
//  StocksApp
//
//  Created by Bauyrzhan Abdi on 01.06.2022.
//

import Foundation
import UIKit

//protocol FavoritesModelProtocol {
//    var id : String {get}
//    var name : String {get}
//    var symbol : String {get}
//    var iconUrl : String {get}
//    var price : String {get}
//    var change : String {get}
//    var changeColor : UIColor {get}
//    var isFavourite : Bool {get set}
//
//    func setFavorite()
//}

final class FavoritesModel : StocksModelProtocol {
    private let favorite : Stock
    private let favoritesService : FavoritesServiceProtocol
    
    init(favorite: Stock) {
        self.favorite = favorite
        favoritesService = ModuleBuilder.shared.favoritesService
        isFavourite = favoritesService.isFavorite(for: id)
    }
    
    var id: String {
        favorite.id
    }
    
    var name: String {
        favorite.name
    }
    
    var symbol: String {
        favorite.symbol.uppercased()
    }
    
    var iconUrl: String {
        favorite.image
    }
    
    var price: String {
        String(format: "%.2f$", favorite.price)
    }
    
    var change: String {
        String(format: "%.2f$ ", favorite.change) + String(format: "(%.2f%%)", favorite.percentage)
    }
    
    var changeColor: UIColor {
        favorite.change >= 0 ? .green : .red
    }
    
    var isFavourite: Bool = true
    
    func setFavorite() {
        isFavourite.toggle()
        
        if isFavourite {
            favoritesService.save(stock: favorite)
        } else {
            favoritesService.remove(stock: favorite)
        }
    }
}
