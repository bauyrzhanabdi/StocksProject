//
//  FavoritesPresenter.swift
//  StocksApp
//
//  Created by Bauyrzhan Abdi on 01.06.2022.
//

import Foundation
import UIKit

protocol FavoritesViewProtocol : AnyObject {
    func updateView()
    func updateView(withLoader isLoading : Bool)
    func updateView(withError message : String)
}

protocol FavoritesPresenterProtocol {
    var view : FavoritesViewProtocol? {get set}
    var itemsCount : Int {get}
    
    func loadFavorites()
    func model(for indexPath : IndexPath) -> StocksModelProtocol
}

final class FavoritesPresenter : FavoritesPresenterProtocol {
    
    weak var view: FavoritesViewProtocol?
    private let service : FavoritesServiceProtocol 
    private var favorites : [StocksModelProtocol] = []
    
    var itemsCount: Int {
        favorites.count
    }
    
    init(service: FavoritesServiceProtocol) {
        self.service = service
    }
    
    
    func loadFavorites() {
        favorites = service.favoriteModels().map({ favorite in
            FavoritesModel(favorite: favorite)})
    }
    
    func model(for indexPath : IndexPath) -> StocksModelProtocol {
        return favorites[indexPath.row]
    }
   
}
