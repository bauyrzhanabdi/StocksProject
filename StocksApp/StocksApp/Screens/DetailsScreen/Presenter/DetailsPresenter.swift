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
    var title : String? { get }
    var favoriteButtonIsSelected : Bool {get}
    
    func loadChart()
    func modelStock() -> StocksModelProtocol
    func favoriteButtonTapped()
}

final class DetailsPresenter : DetailsPresenterProtocol {
    weak var view: DetailsViewProtocol?
    
    private let model : StocksModelProtocol
    private let service : StocksServiceProtocol
    private var detail : DetailsModelProtocol?
    

    var favoriteButtonIsSelected : Bool {
        model.isFavourite
    }
    
    var title : String? {
        model.symbol
    }
    
    
    init(service: StocksServiceProtocol, model: StocksModelProtocol) {
        self.service = service
        self.model = model
    }
    
    
    func loadChart() {
        view?.updateView(withLoader: true)
        
        service.getDetails(id: model.id) { [weak self] result in
            self?.view?.updateView(withLoader: false)
            
            switch result {
            case .success(let detail):
                self?.detail = DetailsModel(detail: detail)
                self?.view?.updateView()
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func modelStock() -> StocksModelProtocol {
        return self.model
    }
    
    func favoriteButtonTapped() {
        model.setFavorite()
    }
   
}
