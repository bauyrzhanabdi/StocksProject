//
//  ModuleBuilder.swift
//  StocksApp
//
//  Created by Bauyrzhan Abdi on 30.05.2022.
//

import Foundation
import UIKit

final class ModuleBuilder {
    private init() {}
    
    private lazy var client : NetworkService = {
       Network()
    }()
    
    
    static let shared : ModuleBuilder = .init()
    
    private func networkService() -> NetworkService {
        client
    }
    
    private func stocksService() -> StocksServiceProtocol {
        StocksService(client: client)
    }
    
    private func stocksModule() -> UIViewController {
        let service = StocksService(client: client)
        let presenter = StocksPresenter(service: service)
        let view = StocksViewController(presenter: presenter)
        
        presenter.view = view
       
        return view
    }
    
    private func favoritesModule() -> UIViewController {
        FavouritesViewController()
    }
    
    private func searchModule() -> UIViewController {
        SearchViewController()
    }
    
    func detailsModule(stock : StocksModelProtocol) -> UIViewController {
        let service = StocksService(client: client)
        let presenter = DetailsPresenter(service: service, stock: stock)
        let view = DetailsViewController(presenter: presenter)
        
        presenter.view = view
        
        return view
    }
    
    func tabBarController() -> UIViewController {
        let tabBar = UITabBarController()
        let stocksVC = stocksModule()
        let favoritesVC = favoritesModule()
        let searchVC = searchModule()
        
        
        stocksVC.tabBarItem = UITabBarItem(title: "Stocks", image: UIImage(systemName: "chart.xyaxis.line"), tag: 0)
        favoritesVC.tabBarItem = UITabBarItem(title: "Favourite", image: UIImage(systemName: "star"), tag: 1)
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        
        tabBar.viewControllers = [stocksVC, favoritesVC, searchVC].map({ controller in
            UINavigationController(rootViewController: controller)
        })
        tabBar.tabBar.backgroundColor = .white
        return tabBar
    }
    
    
}
