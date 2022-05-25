//
//  ViewController.swift
//  StocksApp
//
//  Created by Bauyrzhan Abdi on 25.05.2022.
//

import UIKit

final class StocksViewController: UIViewController {

    // MARK: - Properties
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
        label.textColor = UIColor(red: 26/255, green: 26/255, blue: 26/255, alpha: 1.0)
        label.font = .systemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cellColor : [UIColor] = [
        UIColor(red: 240/255, green: 244/255, blue: 247/255, alpha: 1.0),
        UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    ]
    
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
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            pageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pageLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 35),
            pageLabel.heightAnchor.constraint(equalToConstant: 32),
            pageLabel.widthAnchor.constraint(equalToConstant: 98),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: pageLabel.bottomAnchor, constant: 18),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Extensions

extension StocksViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.typeName, for: indexPath) as? StockCell else {fatalError("cell is null")}
        cell.mainView.backgroundColor = cellColor[indexPath.row % 2]
        return cell
    }
}

extension StocksViewController : UITableViewDelegate {
    
}

extension NSObject {
    static var typeName : String {
        String(describing: self)
    }
}
