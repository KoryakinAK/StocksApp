//
//  StockCell.swift
//  StocksApp
//
//  Created by Alexey Koryakin on 20.03.2021.
//

import UIKit
import Kingfisher

class StockCell: UITableViewCell {
    static var reuseIdentifier: String = "StockCell"
    static var suggestedCellHeight: CGFloat = 100

    let ticker = UILabel()
    let name = UILabel()
    let currentPrice = UILabel()
    let priceChange = UIPriceChangeLabel()
    let logo = UIImageView()
    let favIcon = UIButton(type: .custom)
    let favIconConfiguration = UIImage.SymbolConfiguration(pointSize: 22, weight: .bold)

    func configure(with stock: Stock) {
        ticker.text = stock.ticker
        ticker.font = UIFont.boldSystemFont(ofSize: 30)

        name.text = stock.name
        name.font = UIFont.systemFont(ofSize: 24)
        name.textColor = .secondaryLabel

        currentPrice.text = formatCurrentPriceFor(price: stock.currentPrice)
        currentPrice.font = UIFont.boldSystemFont(ofSize: 30)

        priceChange.text = formatPriceChangeFor(openPriceValue: stock.openPrice, currentPriceValue: stock.currentPrice)
        priceChange.font = UIFont.systemFont(ofSize: 24)

        favIcon.setImage(UIImage(systemName: "star", withConfiguration: favIconConfiguration)?
                            .withRenderingMode(.alwaysOriginal)
                            .withTintColor(.label), for: .normal)
        let roundProccessor = RoundCornerImageProcessor(cornerRadius: 20)
        logo.kf.indicatorType = .activity
        logo.kf.setImage(with: URL(string: "https://finnhub.io/api/logo?symbol=\(stock.ticker)")!, options: [
                            .processor(roundProccessor)
        ]) // TODO: Сделать по-человечески

    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let allCellObjectsList: [UIView] = [name, currentPrice, priceChange, logo, ticker]
        allCellObjectsList.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview($0)
        }
        self.backgroundColor = .systemBackground
        self.selectionStyle = .none
        self.currentPrice.textAlignment = .right
        self.priceChange.textAlignment = .right
        self.name.textAlignment = .left
        self.ticker.textAlignment = .left

        // MARK: - Cell content autolayout
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            logo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            logo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            logo.widthAnchor.constraint(equalTo: logo.heightAnchor),

            currentPrice.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.30),
            currentPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            currentPrice.bottomAnchor.constraint(equalTo: contentView.centerYAnchor),

            priceChange.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            priceChange.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            priceChange.widthAnchor.constraint(equalTo: currentPrice.widthAnchor),

            name.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            name.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 12),
            name.trailingAnchor.constraint(equalTo: currentPrice.leadingAnchor, constant: -8),
//            name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            ticker.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 12),
            ticker.bottomAnchor.constraint(equalTo: contentView.centerYAnchor),
            ticker.trailingAnchor.constraint(equalTo: name.trailingAnchor)
        ])
    }

    private func formatCurrentPriceFor(price: Float) -> String {
        let formattedValue = StockDataFormatter.priceFormatter().string(from: price as NSNumber)
        return formattedValue ?? "0.0"
    }

    private func formatPriceChangeFor(openPriceValue: Float, currentPriceValue: Float) -> String {
        let priceChangePercent = (currentPriceValue - openPriceValue) / openPriceValue
        let formattedValue = StockDataFormatter.priceChangeFormatter().string(from: priceChangePercent as NSNumber)
        return formattedValue ?? "00.00 %"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
