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
    private lazy var nameLabel : UILabel = createLabel(fontSize: 12, fontWeight: 600, textColor: UIColor.DetailsViewController.blackColor)
    private lazy var priceLabel : UILabel = createLabel(fontSize: 28, fontWeight: 700, textColor: UIColor.DetailsViewController.blackColor)
    private lazy var changeLabel : UILabel = createLabel(fontSize: 12, fontWeight: 600, textColor: UIColor.DetailsViewController.greenColor)
    
    private lazy var companyView : UIView = createView()
    private lazy var priceView : UIView = createView()
    private lazy var chartView : UIView = createView()
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        presenter.loadChart()
    }
    
    
    
    // MARK: - Methods
    private func setup() {
        view.addSubview(priceView)
        view.addSubview(chartView)
        
        setupView()
        setupSubViews()
        setupConstraints()
        setupFavoriteButton()
        configure()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = presenter.title
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupSubViews() {
        priceView.addSubview(priceLabel)
        priceView.addSubview(changeLabel)
        
        chartView.backgroundColor = .yellow
    }
    
    private func setupFavoriteButton() {
        let button = UIButton()
        button.setImage(UIImage(named: "favorite-off"), for: .normal)
        button.setImage(UIImage(named: "favorite-on"), for: .selected)
        button.tintColor = UIColor.DetailsViewController.blackColor
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        button.isSelected = presenter.favoriteButtonIsSelected
        button.addTarget(self, action: #selector(favoriteButtonPressed), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    private func configure() {
        let stock = presenter.modelStock()
        priceLabel.text = stock.price
        changeLabel.text = stock.change
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            priceView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            priceView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            priceView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            priceView.heightAnchor.constraint(equalToConstant: 200),
            
            priceLabel.centerXAnchor.constraint(equalTo: priceView.centerXAnchor),
            priceLabel.topAnchor.constraint(equalTo: priceView.topAnchor, constant: 63),
            
            changeLabel.leadingAnchor.constraint(equalTo: priceView.leadingAnchor, constant: 141),
            changeLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            
            chartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            chartView.topAnchor.constraint(equalTo: priceView.bottomAnchor, constant: 50),
            chartView.heightAnchor.constraint(equalToConstant: 300),
            chartView.widthAnchor.constraint(equalToConstant: 300)
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
    
    
    @objc private func favoriteButtonPressed(_ sender : UIButton) {
        sender.isSelected.toggle()
        presenter.favoriteButtonTapped()
    }
}
// MARK: - Extensions
extension DetailsViewController : DetailsViewProtocol {
    func updateView() {
//        print("Updated")
    }
    
    func updateView(withLoader isLoading: Bool) {
//        print("Loader is - ", isLoading, " at ", Date())
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
