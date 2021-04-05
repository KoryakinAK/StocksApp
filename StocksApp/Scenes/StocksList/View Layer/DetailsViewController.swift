//
//  DetailsViewController.swift
//  StocksApp
//
//  Created by Alexey Koryakin on 28.03.2021.
//

import UIKit

protocol DetailsDisplayLogic: class {
    var selectedStock: Stock { get set }
    func displaySelected(stock: Stock)
}

class DetailsViewController: UIViewController, DetailsDisplayLogic {
    let stockInfoTableView = UITableView(frame: .zero, style: .grouped)
    let stockNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .justified
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.numberOfLines = 0
        label.backgroundColor = .clear
        return label
    }()
    let stockNameBackground = UIImageView()
    var selectedStock = Stock(ticker: "", name: "", currentPrice: 0.00, openPrice: 0.00, country: "", marketCapitalization: 0.00, finnhubIndustry: "") {
        willSet {
            values[0] = newValue.ticker
            values[1] = newValue.country
            values[2] = String(newValue.marketCapitalization)
            values[3] = newValue.finnhubIndustry
            stockNameLabel.text = newValue.name
            self.stockInfoTableView.reloadData()
        }
    }

    let titles = ["Тикер", "Страна", "Капитализация", "Индустрия"]
    var values = [String].init(repeating: "-", count: 5)

    /* enum stockTableViewConfiguration: Int {
     case Name = 0
     case Ticker = 1
     case Price = 2
     case PriceChange = 3
     case Volume = 4
     case Chart = 5
     }*/

    override func viewDidLoad() {
        super.viewDidLoad()
        view.self.backgroundColor = .systemBackground
        setupView()
        setStockInfoTableView()
    }

    func setStockInfoTableView() {
        stockInfoTableView.delegate = self
        stockInfoTableView.dataSource = self
        stockInfoTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stockInfoTableView)
        stockInfoTableView.topAnchor.constraint(equalTo: self.stockNameLabel.bottomAnchor).isActive = true
        stockInfoTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        stockInfoTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        stockInfoTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        stockInfoTableView.showsVerticalScrollIndicator = false
        stockInfoTableView.register(DetailsCell.self, forCellReuseIdentifier: DetailsCell.reuseIdentifier)
        stockInfoTableView.backgroundColor = .clear
        stockInfoTableView.separatorColor = .clear
        stockInfoTableView.isScrollEnabled = false
    }

    func setupView() {
        self.view.addSubview(stockNameLabel)
        NSLayoutConstraint.activate([
            stockNameLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            stockNameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 7),
            stockNameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 7)
        ])
    }

    func displaySelected(stock: Stock) {
        self.selectedStock = stock
    }
}

extension DetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DetailsCell.suggestedCellHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsCell.reuseIdentifier, for: indexPath) as? DetailsCell else {
            fatalError()
        }
        cell.configure(with: values[indexPath.row], for: titles[indexPath.row])
        return cell
    }
}
