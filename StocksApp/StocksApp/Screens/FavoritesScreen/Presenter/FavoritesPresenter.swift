//
//  FavoritesPresenter.swift
//  StocksApp
//
//  Created by Bauyrzhan Abdi on 01.06.2022.
//

// в файл менеджере хранишь только айдишки
// в фаворитПрезентере делаешь ссылку на стокмоделпротокол и хранишь все стоки
// пишешь функцию которая при вызове сравнивает айдишки из файл менеджера с айдишками всех стоков э
// и хранит только избранные у которых айдишка совпала
 
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
    
    func loadView()
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
    
    func loadView() {
        startObservingFavoriteNotifications()
        loadFavorites()
    }
    
    func loadFavorites() {
        let stocks = service.favoriteStocks()
        favorites = stocks.map({ stock in StocksModel(stock: stock)})
    }
    
    func model(for indexPath : IndexPath) -> StocksModelProtocol {
        return favorites[indexPath.row]
    }
   
}

extension FavoritesPresenter : FavoritesUpdateServiceProtocol {
    func setFavorite(notification: Notification) {
        loadFavorites()
        view?.updateView()
    }
}
