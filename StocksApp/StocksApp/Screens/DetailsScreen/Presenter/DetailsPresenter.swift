//
//  DetailsPresenter.swift
//  StocksApp
//
//  Created by Bauyrzhan Abdi on 31.05.2022.
//

import Foundation
import UIKit

protocol DetailsViewProtocol : AnyObject {
    func updateView()
    func updateView(withLoader isLoading : Bool)
    func updateView(withError message : String)
}

protocol DetailsPresenterProtocol {
    var view : DetailsViewProtocol? {get set}
    
    func loadChart()
    func model() -> StocksModelProtocol
}

final class DetailsPresenter : DetailsPresenterProtocol {
    weak var view: DetailsViewProtocol?
    private let service : StocksServiceProtocol
    private let stock : StocksModelProtocol
    private var detail : DetailsModelProtocol?
    
    
    init(service: StocksServiceProtocol, stock: StocksModelProtocol) {
        self.service = service
        self.stock = stock
    }
    
    
    func loadChart() {
        view?.updateView(withLoader: true)
        
        service.getDetails(id: stock.id) { [weak self] result in
            self?.view?.updateView(withLoader: false)
            
            switch result {
            case .success(let detail):
                self?.detail = DetailsModel(detail: detail)
                self?.view?.updateView()
//                print("prices --", self?.detail?.prices as Any)
//                print("caps --", self?.detail?.caps as Any)
//                print("volumes --", self?.detail?.volumes as Any)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func model() -> StocksModelProtocol {
        return stock
    }
   
}
