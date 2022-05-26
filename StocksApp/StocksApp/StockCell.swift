//
//  StockCell.swift
//  StocksApp
//
//  Created by Bauyrzhan Abdi on 25.05.2022.
//

import UIKit

final class StockCell : UITableViewCell {
    // MARK: - Properties
    private lazy var iconView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.image = UIImage(named: "YNDX")
        return image
    }()
    
    public lazy var mainView : UIView = {
        createView()
        
    }()
    private lazy var infoView : UIView = createView()
    private lazy var tickerView : UIView = createView()
    
    private lazy var symbolLabel : UILabel = createLabel(text: "YNDX", fontSize: 18, fontWeight: 700, red: 26, green: 26, blue: 26)
    private lazy var nameLabel : UILabel = createLabel(text: "Yandex, LLC", fontSize: 12, fontWeight: 600, red: 0, green: 0, blue: 0)
    private lazy var priceLabel : UILabel = createLabel(text: "4 764,6 ₽", fontSize: 18, fontWeight: 700, red: 26, green: 26, blue: 26)
    private lazy var deltaLabel : UILabel = createLabel(text: "+55 ₽ (1,15%)", fontSize: 18, fontWeight: 600, red: 36, green: 178, blue: 93)
    
    private lazy var starButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.tintColor = UIColor.StockCell.starButtonTintColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    private func setup() {
        contentView.backgroundColor = .white
        contentView.addSubview(mainView)
        mainView.layer.cornerRadius = 16
        mainView.clipsToBounds = true
        
        mainView.addSubview(iconView)
        mainView.addSubview(infoView)
        mainView.addSubview(priceLabel)
        mainView.addSubview(deltaLabel)
        
        setupView()
        setupConstraints()
    }
    

    private func setupView() {
        infoView.addSubview(tickerView)
        infoView.addSubview(nameLabel)

        
        tickerView.addSubview(symbolLabel)
        tickerView.addSubview(starButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            iconView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8),
            iconView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            iconView.heightAnchor.constraint(equalToConstant: 52),
            iconView.widthAnchor.constraint(equalToConstant: 52),
            
            infoView.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            infoView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 14),
            infoView.heightAnchor.constraint(equalToConstant: 40),
            
            tickerView.leadingAnchor.constraint(equalTo: infoView.leadingAnchor),
            tickerView.topAnchor.constraint(equalTo: infoView.topAnchor),
            tickerView.trailingAnchor.constraint(equalTo: infoView.trailingAnchor),
            tickerView.heightAnchor.constraint(equalToConstant: 24),
            
            symbolLabel.leadingAnchor.constraint(equalTo: tickerView.leadingAnchor),
            symbolLabel.topAnchor.constraint(equalTo: tickerView.topAnchor),
            symbolLabel.heightAnchor.constraint(equalToConstant: 24),
            
            nameLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 16),
            
            starButton.leadingAnchor.constraint(equalTo: symbolLabel.trailingAnchor, constant: 6),
            starButton.centerYAnchor.constraint(equalTo: tickerView.centerYAnchor),
            starButton.heightAnchor.constraint(equalToConstant: 16),
            starButton.widthAnchor.constraint(equalToConstant: 16),
            
            priceLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 14),
            priceLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -17),
            priceLabel.heightAnchor.constraint(equalToConstant: 24),
            
            deltaLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            deltaLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -12),
            deltaLabel.heightAnchor.constraint(equalToConstant: 16)
            
        ])
    }
    
    private func createLabel(text : String, fontSize : CGFloat, fontWeight : CGFloat, red: CGFloat, green : CGFloat, blue : CGFloat) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = UIColor.StockCell.labelColor(red, green, blue)
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

extension UIColor {
    fileprivate enum StockCell {
        static var starButtonTintColor : UIColor {
            UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1)
        }
        
        static func labelColor(_ red : CGFloat, _ green: CGFloat, _ blue : CGFloat) -> UIColor {
            return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
        }
    }
}
