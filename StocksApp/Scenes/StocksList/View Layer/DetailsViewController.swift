//
//  DetailsViewController.swift
//  StocksApp
//
//  Created by Alexey Koryakin on 28.03.2021.
//

import UIKit

protocol DetailsDisplayLogic: class {
    var handlingArea: UIView { get }
    var selectedStock: Stock! { get set }
    func displaySelected(stock: Stock)
}

class DetailsViewController: UIViewController, DetailsDisplayLogic {
    let handlingArea = UIView()
    var stockInfoTableView = UITableView(frame: .zero, style: .grouped)
    var selectedStock: Stock! {
        willSet {
            values[0] = newValue.name
            values[1] = newValue.ticker
            values[2] = newValue.country
            values[3] = String(newValue.marketCapitalization)
            values[4] = newValue.finnhubIndustry
            self.stockInfoTableView.reloadData()
        }
    }

    let titles = ["Имя", "Тикер", "Страна", "Капитализация", "Индустрия"]
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
        setHandlingArea()
        setStockInfoTableView()
        setStockPlaceHolder()
    }

    func setStockPlaceHolder() {
        self.selectedStock = Stock(ticker: "", name: "", currentPrice: 0.00, openPrice: 0.00, isFaved: false, country: "", marketCapitalization: 0.00, finnhubIndustry: "")
    }

    func setStockInfoTableView() {
        stockInfoTableView.delegate = self
        stockInfoTableView.dataSource = self
        stockInfoTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stockInfoTableView)
        stockInfoTableView.topAnchor.constraint(equalTo: self.handlingArea.bottomAnchor).isActive = true
        stockInfoTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        stockInfoTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        stockInfoTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        stockInfoTableView.showsVerticalScrollIndicator = false
        stockInfoTableView.register(DetailsCell.self, forCellReuseIdentifier: DetailsCell.reuseIdentifier)
        stockInfoTableView.backgroundColor = .clear
        stockInfoTableView.separatorColor = .clear
        stockInfoTableView.isScrollEnabled = false
    }

    func setHandlingArea() {
        handlingArea.translatesAutoresizingMaskIntoConstraints = false
        handlingArea.backgroundColor = .cyan
        self.view.addSubview(handlingArea)
        NSLayoutConstraint.activate([
            handlingArea.topAnchor.constraint(equalTo: self.view.topAnchor),
            handlingArea.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            handlingArea.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            handlingArea.heightAnchor.constraint(equalToConstant: 120)

        ])
    }

    func displaySelected(stock: Stock) {
        self.selectedStock = stock
    }
}

extension DetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
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
