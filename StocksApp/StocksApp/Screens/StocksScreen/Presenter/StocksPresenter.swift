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
    private var stocks : [StocksModelProtocol] = []
    
    var itemsCount: Int {
        stocks.count
    }
    
    init(service: StocksServiceProtocol) {
        self.service = service
    }
    
    
    func loadView() {
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
