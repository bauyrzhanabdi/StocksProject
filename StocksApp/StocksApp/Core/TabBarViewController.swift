//
//  TabBarController.swift
//  StocksApp
//
//  Created by Bauyrzhan Abdi on 27.05.2022.
//

import Foundation
import UIKit

final class TabBarViewController : UITabBarController {
    
    // MARK: - Properties
    private let stocksVC: StocksViewController = {
        let client = Network()
        let service = StocksService(client: client)
        let presenter = StocksPresenter(service: service)
        let view = StocksViewController(presenter: presenter)
        
        presenter.view = view
       
        return view
    }()
    private let favoritesVC = FavoritesViewController(presenter: FavoritesPresenter(service: FavoritesService()))
    private let searchVC = SearchViewController()
//    private let detailsVC = DetailsViewController()
    
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
//        stocksVC.delegate = detailsVC
    }
    
    // MARK: - Methods
    private func setup() {
        stocksVC.tabBarItem = UITabBarItem(title: "Stocks", image: UIImage(systemName: "chart.xyaxis.line"), tag: 0)
        favoritesVC.tabBarItem = UITabBarItem(title: "Favourite", image: UIImage(systemName: "star"), tag: 1)
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        
        self.setViewControllers([
            UINavigationController(rootViewController: stocksVC),
            UINavigationController(rootViewController: favoritesVC),
            UINavigationController(rootViewController: searchVC)
        ], animated: false)
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .white
    }
    
    private func stocksModule() {
        
    }
    
    private func stocksModule() -> UIViewController {
        let client = Network()
        let service = StocksService(client: client)
        let presenter = StocksPresenter(service: service)
        let view = StocksViewController(presenter: presenter)
        
        presenter.view = view
        return view
    }
}
