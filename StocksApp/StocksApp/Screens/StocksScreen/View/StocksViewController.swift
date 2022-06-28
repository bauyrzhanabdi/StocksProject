//
//  ViewController.swift
//  StocksApp
//
//  Created by Bauyrzhan Abdi on 25.05.2022.
//

import UIKit

final class StocksViewController: UIViewController {
    // MARK: - Initialization
    
    private let presenter : StocksPresenterProtocol
    
    init(presenter: StocksPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(StockCell.self, forCellReuseIdentifier: StockCell.typeName)

        return tableView
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
        presenter.loadView()
    }
    
    
    // MARK: - Methods
    
    private func setupSubview() {
        view.backgroundColor = .white
        title = "Stocks"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true

        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Extensions

extension StocksViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.typeName, for: indexPath) as? StockCell else {fatalError("cell is null")}
        cell.mainView.backgroundColor = cellColor[indexPath.row % 2]
        cell.configure(with: presenter.model(for: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.itemsCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        76
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(ModuleBuilder.shared.detailsModule(stock: presenter.model(for: indexPath)), animated: true)
        
    }
}

extension StocksViewController : UITableViewDelegate {
    
}

extension StocksViewController : StocksViewProtocol {
    func updateView() {
        tableView.reloadData()
    }
    
    func updateView(withLoader isLoading: Bool) {
        print("Loader is - ", isLoading, " at ", Date())
    }
    
    func updateView(withError message: String) {
        fatalError("Error -- \(message)")
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



