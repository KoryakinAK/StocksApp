//
//  DetailsViewController.swift
//  StocksApp
//
//  Created by Alexey Koryakin on 28.03.2021.
//

import UIKit

protocol DetailsDisplayLogic: AnyObject {
    var selectedStock: Stock { get set }
    func displaySelected(stock: Stock)
}

class DetailsViewController: UIViewController, DetailsDisplayLogic {
    static let sideInsectValue: CGFloat = 8

    let stockBasicInfoCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = sideInsectValue
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: sideInsectValue, bottom: 0, right: sideInsectValue)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

    let stockInfoTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        tableView.showsVerticalScrollIndicator = false
        tableView.register(DetailsCell.self, forCellReuseIdentifier: DetailsCell.reuseIdentifier)
        tableView.backgroundColor = .clear
        tableView.separatorColor = .black
        tableView.isScrollEnabled = false
        return tableView
    }()

    let stockNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .justified
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.minimumScaleFactor = 0.7
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()

    // TODO: Вынести данные из VC
    var selectedStock = Stock() {
        willSet {
            values[0] = newValue.peBasicExclExtraTTM ?? 0.0
            values[1] = newValue.epsBasicExclExtraItemsAnnual
            values[2] = Double(newValue.marketCapitalization)
            values[3] = newValue.the52WeekHigh
            values[4] = newValue.the52WeekLow
            stockNameLabel.text = newValue.name
            self.stockInfoTableView.reloadData()
        }
    }

    let titles = ["P/E", "EPS", "Капитализация", "52 high", "52 low"]
    let descriptions = ["Цена акции / прибыль", "Прибыль на акцию", "Стоимость компании", "Наивысшая цена за год", "Наименьшая цена за год"]
    var values = [Double].init(repeating: 0, count: 5)
    var lastAnimatedStockCell = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupGradientBackground()
        setupStockBasicInfoCV()
        setStockInfoTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lastAnimatedStockCell = -1
    }

    func setupView() {
        self.view.addSubview(stockNameLabel)
        NSLayoutConstraint.activate([
            stockNameLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            stockNameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 7),
            stockNameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -7)
        ])
    }

    func setupGradientBackground() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        let endColor = UIColor(red: 0.00, green: 0.35, blue: 0.65, alpha: 1.0).cgColor
        let startColor = UIColor(red: 1.00, green: 0.99, blue: 0.89, alpha: 1.00).cgColor
        gradient.colors = [startColor, endColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint =  CGPoint(x: 2, y: 2)
        view.layer.insertSublayer(gradient, at: 0)
    }

    func setupStockBasicInfoCV() {
        view.addSubview(stockBasicInfoCV)
        stockBasicInfoCV.register(DetailsCVCell.self, forCellWithReuseIdentifier: DetailsCVCell.reuseIdentifier)
        stockBasicInfoCV.delegate = self
        stockBasicInfoCV.dataSource = self
        stockBasicInfoCV.topAnchor.constraint(equalTo: self.stockNameLabel.bottomAnchor, constant: 10).isActive = true
        stockBasicInfoCV.heightAnchor.constraint(equalToConstant: 80).isActive = true
        stockBasicInfoCV.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        stockBasicInfoCV.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }

    func setStockInfoTableView() {
        view.addSubview(stockInfoTableView)
        stockInfoTableView.delegate = self
        stockInfoTableView.dataSource = self
        stockInfoTableView.topAnchor.constraint(equalTo: self.stockBasicInfoCV.bottomAnchor).isActive = true
        stockInfoTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        stockInfoTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        stockInfoTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }

    func displaySelected(stock: Stock) {
        self.selectedStock = stock
    }
}

// MARK: - CollectionView Lifecycle
extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = stockBasicInfoCV.dequeueReusableCell(withReuseIdentifier: DetailsCVCell.reuseIdentifier, for: indexPath) as? DetailsCVCell else { fatalError() }
        switch indexPath.row {
        case 0:
            cell.configure(with: selectedStock, for: .country)
        case 1:
            cell.configure(with: selectedStock, for: .industry)
        default:
            cell.configure(with: selectedStock, for: .other)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.bounds.width - (DetailsViewController.sideInsectValue * 4)) / 2
        return CGSize(width: width, height: 80)
    }
}

// MARK: - TableView Lifecycle
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
        cell.configure(values[indexPath.row], for: titles[indexPath.row], with: descriptions[indexPath.row])
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > lastAnimatedStockCell {
            cell.transform = CGAffineTransform(translationX: self.view.bounds.width / 2, y: 0)
            cell.alpha = 0
            UIView.animate(withDuration: 1.3, delay: Double(indexPath.row) * 0.09, usingSpringWithDamping: 0.7, initialSpringVelocity: 11, options: .curveEaseInOut, animations: {
                cell.transform = .identity
                cell.alpha = 1

            })
            lastAnimatedStockCell = indexPath.row
        }
    }
}
