//
//  StockCell.swift
//  StocksApp
//
//  Created by Alexey Koryakin on 20.03.2021.
//

import UIKit

class StockCell: UITableViewCell {
    static var reuseIdentifier: String = "StockCell"
    static var suggestedCellHeight: CGFloat = 100

    let ticker = UILabel()
    let name = UILabel()
    let currentPrice = UILabel()
    let priceChange = UILabel() // TODO: Сделать кастомный тип лейбла с автоматическим цветом
    let logo = UIImageView()
    let favIcon = UIButton(type: .custom)

    func configure(with stock: Stock) {
        ticker.text = stock.ticker
        ticker.font = UIFont.boldSystemFont(ofSize: 26)

        name.text = stock.name
        name.font = UIFont.systemFont(ofSize: 19)

        currentPrice.text = "\(stock.currentPrice)"
        currentPrice.font = UIFont.boldSystemFont(ofSize: 30)

        priceChange.text = "\(stock.priceChange)"
        priceChange.font = UIFont.systemFont(ofSize: 24)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let tickerAndFavIconStackView = UIStackView(arrangedSubviews: [ticker, favIcon])
        tickerAndFavIconStackView.axis = .horizontal

        let allCellObjectsList: [UIView] = [name, currentPrice, priceChange, logo, tickerAndFavIconStackView]
        allCellObjectsList.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview($0)
        }

        logo.backgroundColor = .yellow
        name.backgroundColor = .red
        ticker.backgroundColor = .brown
        priceChange.backgroundColor = .blue
        currentPrice.backgroundColor = .cyan

        // MARK: - Cell content autolayout
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            logo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            logo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            logo.widthAnchor.constraint(equalTo: logo.heightAnchor),

            tickerAndFavIconStackView.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 12),
            tickerAndFavIconStackView.bottomAnchor.constraint(equalTo: contentView.centerYAnchor),

            name.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            name.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 12),

            currentPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            currentPrice.bottomAnchor.constraint(equalTo: contentView.centerYAnchor),

            priceChange.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            priceChange.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
