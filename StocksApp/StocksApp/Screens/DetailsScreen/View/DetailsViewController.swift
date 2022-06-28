//
//  DetailsViewController.swift
//  StocksApp
//
//  Created by Bauyrzhan Abdi on 27.05.2022.
//

import Foundation
import UIKit

final class DetailsViewController : UIViewController {
    
    // MARK: - Initialization
    private let presenter : DetailsPresenterProtocol
    
    
    init(presenter : DetailsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Properties
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
    
    private lazy var companyView : UIView = createView()
    private lazy var priceView : UIView = createView()
    private lazy var charterView : UIView = createView()
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        presenter.loadChart()
    }
    
    
    
    // MARK: - Methods
    private func setup() {
        view.addSubview(companyView)
        view.addSubview(priceView)
        view.addSubview(charterView)
        
        setupViews()
        setupConstraints()
        configure()
    }
    
    private func setupViews() {
        companyView.addSubview(symbolLabel)
        companyView.addSubview(nameLabel)
        companyView.addSubview(starButton)
        
        
        priceView.addSubview(priceLabel)
        priceView.addSubview(changeLabel)
        
        charterView.backgroundColor = .yellow
    }
    
    private func configure() {
        let stock = presenter.model()
        symbolLabel.text = stock.symbol
        nameLabel.text = stock.name
        priceLabel.text = stock.price
        changeLabel.text = stock.change
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
            priceView.heightAnchor.constraint(equalToConstant: 200),
            
            priceLabel.centerXAnchor.constraint(equalTo: priceView.centerXAnchor),
            priceLabel.topAnchor.constraint(equalTo: priceView.topAnchor, constant: 63),
            
            changeLabel.leadingAnchor.constraint(equalTo: priceView.leadingAnchor, constant: 141),
            changeLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            
            charterView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            charterView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            charterView.topAnchor.constraint(equalTo: priceView.bottomAnchor, constant: 50),
            charterView.heightAnchor.constraint(equalToConstant: 300),
            charterView.widthAnchor.constraint(equalToConstant: 300)
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
extension DetailsViewController : DetailsViewProtocol {
    func updateView() {
        print("Updated")
    }
    
    func updateView(withLoader isLoading: Bool) {
        print("Loader is - ", isLoading, " at ", Date())
    }
    
    func updateView(withError message: String) {
        fatalError("Error -- \(message)")
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
    }
}
