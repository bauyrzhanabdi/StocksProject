//
//  DetailsViewController.swift
//  StocksApp
//
//  Created by Bauyrzhan Abdi on 27.05.2022.
//

import Foundation
import UIKit

protocol DetailsViewControllerDelegate {
    func getStocks(stock : Stock)
}

final class DetailsViewController : UIViewController {
    // MARK: - Properties
    private var stock : Stock = Stock(id: "yndx", symbol: "YNDX", name: "Yandex LLC", image: "star", price: 4764.6, change: 55, percentage: 1.15)
    
    private lazy var starButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.tintColor = UIColor.DetailsViewController.blackColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var symbolLabel : UILabel = createLabel(fontSize: 18, fontWeight: 700, textColor: UIColor.DetailsViewController.blackColor)
    private lazy var nameLabel : UILabel = createLabel(fontSize: 12, fontWeight: 600, textColor: UIColor.DetailsViewController.blackColor)
    private lazy var priceLabel : UILabel = createLabel(fontSize: 28, fontWeight: 700, textColor: UIColor.DetailsViewController.blackColor)
    private lazy var changeLabel : UILabel = createLabel(fontSize: 12, fontWeight: 600, textColor: UIColor.DetailsViewController.greenColor)
    private lazy var percentageLabel : UILabel = createLabel(fontSize: 12, fontWeight: 600, textColor: UIColor.DetailsViewController.greenColor)
    
    private lazy var companyView : UIView = createView()
    private lazy var priceView : UIView = createView()
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
    
    
    
    // MARK: - Methods
    private func setup() {
        view.addSubview(companyView)
        view.addSubview(priceView)
        
        setupViews()
        setupConstraints()
        configure()
    }
    
    private func setupViews() {
        companyView.addSubview(symbolLabel)
        companyView.addSubview(nameLabel)
        companyView.addSubview(starButton)
        companyView.layer.shadowColor = UIColor.DetailsViewController.shadowColor.cgColor
        
        priceView.addSubview(priceLabel)
        priceView.addSubview(changeLabel)
        priceView.addSubview(percentageLabel)
        
    }
    
    private func configure() {
//        guard let stock = stock else {fatalError("Stock is empty")}
        symbolLabel.text = stock.symbol.uppercased()
        nameLabel.text = stock.name
        priceLabel.text = String(format: "%.2f$", stock.price)
        changeLabel.text = String(format: "%.2f$", stock.change)
        percentageLabel.text = String(format: "(%.2f%%)", stock.percentage)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            companyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            companyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            companyView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            companyView.heightAnchor.constraint(equalToConstant: 99),
            
            symbolLabel.topAnchor.constraint(equalTo: companyView.topAnchor, constant: 42),
            symbolLabel.centerXAnchor.constraint(equalTo: companyView.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 4),
            nameLabel.centerXAnchor.constraint(equalTo: companyView.centerXAnchor),
            
            starButton.topAnchor.constraint(equalTo: companyView.topAnchor, constant: 50),
            starButton.trailingAnchor.constraint(equalTo: companyView.trailingAnchor, constant: -23),
            
            priceView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            priceView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            priceView.topAnchor.constraint(equalTo: companyView.bottomAnchor),
            priceView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            priceLabel.centerXAnchor.constraint(equalTo: priceView.centerXAnchor),
            priceView.topAnchor.constraint(equalTo: priceView.topAnchor, constant: 63),
            
            changeLabel.leadingAnchor.constraint(equalTo: priceView.leadingAnchor, constant: 141),
            changeLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            
            percentageLabel.leadingAnchor.constraint(equalTo: changeLabel.trailingAnchor, constant: 5),
            percentageLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor,constant: 8)
        ])
    }
    
    private func createLabel(fontSize : CGFloat, fontWeight : CGFloat, textColor : UIColor) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.font = .systemFont(ofSize: fontSize, weight: UIFont.Weight(rawValue: fontWeight))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func createView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    
    @objc private func buttonPressed(_ sender : UIButton) {}
}
// MARK: - Extensions
extension DetailsViewController : DetailsViewControllerDelegate {
    func getStocks(stock : Stock) {
        self.stock = stock
    }
    
    
}


extension UIColor {
    fileprivate enum DetailsViewController {
        static var blackColor : UIColor {
            UIColor(red: 26/255, green: 26/255, blue: 26/255, alpha: 1)
        }
        
        static var greenColor : UIColor {
            UIColor(red: 36/255, green: 178/255, blue: 93/255, alpha: 1)
        }
        
        static var shadowColor : UIColor {
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.05)
        }
    }
}
