//
//  DetailsCell.swift
//  StocksApp
//
//  Created by Alexey Koryakin on 29.03.2021.
//

import UIKit

class DetailsCell: UITableViewCell {
    static var reuseIdentifier: String = "DetailsCell"
    static var suggestedCellHeight: CGFloat = 55

    let columnLabel = UILabel()
    let valueLabel = UILabel()

    func configure(with value: String, for column: String) {
        valueLabel.text = value
        valueLabel.font = UIFont.boldSystemFont(ofSize: 28)
        valueLabel.textColor = .label
        valueLabel.textAlignment = .right

        columnLabel.text = column
        columnLabel.font = UIFont.boldSystemFont(ofSize: 28)
        columnLabel.textColor = .label
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.valueLabel.adjustsFontSizeToFitWidth = true
        self.columnLabel.adjustsFontSizeToFitWidth = true
        self.valueLabel.minimumScaleFactor = 0.7
        self.columnLabel.minimumScaleFactor = 0.7

        let allCellObjectsList: [UIView] = [valueLabel, columnLabel]
        allCellObjectsList.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview($0)
        }
        self.selectionStyle = .none

        // MARK: - Cell content autolayout
        NSLayoutConstraint.activate([
            columnLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            columnLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            columnLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),

            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            valueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            valueLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5)
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
