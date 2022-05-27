//
//  FavoritesViewController.swift
//  StocksApp
//
//  Created by Bauyrzhan Abdi on 27.05.2022.
//

import Foundation
import UIKit

final class FavouritesViewController: UIViewController {
    // MARK: - Properties
    private lazy var pageLabel : UILabel = {
        let label = UILabel()
        label.text = "Favorites"
        label.textColor = UIColor.FavoritesViewController.textColor
        label.font = .systemFont(ofSize: 28, weight: UIFont.Weight(rawValue: 700))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        view.addSubview(pageLabel)
        
        NSLayoutConstraint.activate([
            pageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pageLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 35),
            pageLabel.heightAnchor.constraint(equalToConstant: 32),
        ])
    }
}

// MARK: Extensions
extension UIColor {
    fileprivate enum FavoritesViewController {
        static var textColor : UIColor {
            UIColor(red: 26/255, green: 26/255, blue: 26/255, alpha: 1.0)
        }
    }
}
