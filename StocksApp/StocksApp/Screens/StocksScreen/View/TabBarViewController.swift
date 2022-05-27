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
    private let stocksVC = StocksViewController()
    private let favoritesVC = FavouritesViewController()
    private let searchVC = SearchViewController()
    private let detailsVC = DetailsViewController()
    
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        stocksVC.delegate = detailsVC
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    // MARK: - Methods
    private func setup() {
        stocksVC.tabBarItem.image = UIImage(systemName: "chart.xyaxis.line")
        favoritesVC.tabBarItem.image = UIImage(systemName: "star")
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        self.setViewControllers([stocksVC, favoritesVC, searchVC], animated: false)
        setupTabBar()
    }
    
    private func setupTabBar() {
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .white
    }
}
