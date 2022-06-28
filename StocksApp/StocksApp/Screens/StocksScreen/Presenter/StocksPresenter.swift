//
//  StocksPresenter.swift
//  StocksApp
//
//  Created by Bauyrzhan Abdi on 30.05.2022.
//

import Foundation
import UIKit

protocol StocksViewProtocol : AnyObject {
    func updateView()
    func updateCell(for indexPath : IndexPath)
    func updateView(withLoader isLoading : Bool)
    func updateView(withError message : String)
}

protocol StocksPresenterProtocol {
    var view : StocksViewProtocol? {get set}
    var itemsCount : Int {get}
    
    func loadView()
    func model(for indexPath : IndexPath) -> StocksModelProtocol
}

final class StocksPresenter : StocksPresenterProtocol {
    weak var view: StocksViewProtocol?
    private let service : StocksServiceProtocol
    var favorite : FavoritesPresenterProtocol?
    private var stocks : [StocksModelProtocol] = []
    
    var itemsCount: Int {
        stocks.count
    }
    
    init(service: StocksServiceProtocol) {
        self.service = service
    }
    
    
    func loadView() {
        startObservingFavoriteNotifications()
        view?.updateView(withLoader: true)
        service.getStocks { [weak self] result in
            self?.view?.updateView(withLoader: false)
            
            switch result {
            case .success(let stocks):
                self?.stocks = stocks.map { stock in StocksModel(stock: stock) }
                self?.view?.updateView()
            case .failure(let error):
                self?.view?.updateView(withError: error.localizedDescription)
            }
            
        }
        
    }
    
    func model(for indexPath : IndexPath) -> StocksModelProtocol {
        return stocks[indexPath.row]
    }
   
}

extension StocksPresenter : FavoritesUpdateServiceProtocol {
    func setFavorite(notification: Notification) {
        guard let id = notification.stockID,
              let index = stocks.firstIndex(where: {$0.id == id})
        else {return}
        
        let indexPath = IndexPath(row: index, section: 0)
        view?.updateCell(for: indexPath)
        favorite?.view?.updateView()
    }
    
    
}
