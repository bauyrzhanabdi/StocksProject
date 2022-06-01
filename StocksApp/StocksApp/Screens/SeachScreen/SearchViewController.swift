//
//  SearchViewController.swift
//  StocksApp
//
//  Created by Bauyrzhan Abdi on 27.05.2022.
//

import Foundation
import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        setupSubview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods

    private func setupSubview() {
        view.backgroundColor = .white
        title = "Search"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: Extensions
extension UIColor {
    fileprivate enum SearchViewController {
        static var textColor : UIColor {
            UIColor(red: 26/255, green: 26/255, blue: 26/255, alpha: 1.0)
        }
    }
}
