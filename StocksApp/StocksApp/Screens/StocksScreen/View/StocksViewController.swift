//
//  ViewController.swift
//  StocksApp
//
//  Created by Bauyrzhan Abdi on 25.05.2022.
//

import UIKit

final class StocksViewController: UIViewController {

    // MARK: - Properties
    public weak var delegate : DetailsViewController?
    
    private var stocks : [Stock] = []
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(StockCell.self, forCellReuseIdentifier: StockCell.typeName)

        return tableView
    }()
    
    private lazy var pageLabel : UILabel = {
        let label = UILabel()
        label.text = "Stocks"
        label.textColor = UIColor.StockViewController.textColor
        label.font = .systemFont(ofSize: 28, weight: UIFont.Weight(rawValue: 700))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cellColor : [UIColor] = [
        UIColor.StockViewController.greyCellColor,
        UIColor.StockViewController.whiteCellColor
    ]
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        setupSubview()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStocks()
    }
    
    
    // MARK: - Methods
    
    private func setupSubview() {
        view.backgroundColor = .white
        view.addSubview(pageLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            pageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pageLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 35),
            pageLabel.heightAnchor.constraint(equalToConstant: 32),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: pageLabel.bottomAnchor, constant: 18),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func getStocks() {
        let client = Network()
        let service : StocksServiceProtocol = StocksService(client: client)
        
        service.getStocks { [weak self] result in
            switch result {
            case .success(let stocks):
                self?.stocks = stocks
                self?.tableView.reloadData()
            case .failure(let error):
                self?.showError(error.localizedDescription)
            }
        }
    }
    
    private func showError(_ message : String) {
        print(message)
    }
    
}

// MARK: - Extensions

extension StocksViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.typeName, for: indexPath) as? StockCell else {fatalError("cell is null")}
        cell.mainView.backgroundColor = cellColor[indexPath.row % 2]
        cell.configure(with: stocks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        76
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.getStocks(stock: stocks[indexPath.row])
        navigationController?.pushViewController(DetailsViewController(), animated: true)
        
    }
}

extension StocksViewController : UITableViewDelegate {
    
}

extension NSObject {
    static var typeName : String {
        String(describing: self)
    }
}

extension UIColor {
    fileprivate enum StockViewController {
        static var textColor : UIColor {
            UIColor(red: 26/255, green: 26/255, blue: 26/255, alpha: 1.0)
        }
        
        static var whiteCellColor : UIColor {
            UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        }
        
        static var greyCellColor : UIColor {
            UIColor(red: 240/255, green: 244/255, blue: 247/255, alpha: 1.0)
        }
    }
}

// MARK: - Structure

struct Stock : Decodable {
    let id : String
    let symbol : String
    let name : String
    let image : String
    let price : Double
    let change : Double
    let percentage : Double

    enum CodingKeys : String, CodingKey {
        case id, symbol, name, image
        case price = "current_price"
        case change = "price_change_24h"
        case percentage = "price_change_percentage_24h"
    }
}


