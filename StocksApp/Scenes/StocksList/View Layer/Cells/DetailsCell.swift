//
//  DetailsCell.swift
//  StocksApp
//
//  Created by Alexey Koryakin on 29.03.2021.
//

import UIKit

class DetailsCell: UITableViewCell {
    static var reuseIdentifier: String = "DetailsCell"
    static var suggestedCellHeight: CGFloat = 70

    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let valueLabel = UILabel()

    func configure(_ value: Double, for column: String, with description: String) {
        let valueAsString = StockDataFormatter.priceFormatter().string(from: (value as NSNumber)) ?? "0.0"
        valueLabel.text = "$\(valueAsString)"
        valueLabel.font = UIFont.boldSystemFont(ofSize: 28)
        valueLabel.textColor = .black
        valueLabel.textAlignment = .right

        titleLabel.text = column
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.textColor = .black

        descriptionLabel.text = description
        descriptionLabel.font = UIFont.systemFont(ofSize: 23)
        descriptionLabel.textColor = UIColor(cgColor: CGColor(red: 0.235294, green: 0.235294, blue: 0.262745, alpha: 0.6))
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.valueLabel.adjustsFontSizeToFitWidth = true
        self.titleLabel.adjustsFontSizeToFitWidth = true
        self.valueLabel.minimumScaleFactor = 0.7
        self.titleLabel.minimumScaleFactor = 0.7

        let allCellObjectsList: [UIView] = [titleLabel, descriptionLabel, valueLabel]
        allCellObjectsList.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview($0)
        }
        self.selectionStyle = .none

        // MARK: - Cell content autolayout
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.70),

            descriptionLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            descriptionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.70),

            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            valueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            valueLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3, constant: -6)
        ])
    }

    // TODO: - Вынести функцию в extenstion к классу ячейки
    private func formatCurrentPriceFor(price: Float) -> String {
        let formattedValue = StockDataFormatter.priceFormatter().string(from: price as NSNumber)
        return formattedValue ?? "0.0"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
