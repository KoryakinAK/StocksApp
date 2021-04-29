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

    let detailTitleLabel = UILabel()
    let detailDescriptionLabel = UILabel()
    let detailValueLabel = UILabel()

    func configure(_ value: Double, for column: String, with description: String) {
        let valueAsString = StockDataFormatter.priceFormatter().string(from: (value as NSNumber)) ?? "0.0"
        detailValueLabel.text = "$\(valueAsString)"
        detailValueLabel.font = UIFont.boldSystemFont(ofSize: 28)
        detailValueLabel.textColor = .label
        detailValueLabel.textAlignment = .right

        detailTitleLabel.text = column
        detailTitleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        detailTitleLabel.textColor = .label

        detailDescriptionLabel.text = description
        detailDescriptionLabel.font = UIFont.systemFont(ofSize: 23)
        detailDescriptionLabel.textColor = .secondaryLabel

    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.detailValueLabel.adjustsFontSizeToFitWidth = true
        self.detailTitleLabel.adjustsFontSizeToFitWidth = true
        self.detailValueLabel.minimumScaleFactor = 0.7
        self.detailTitleLabel.minimumScaleFactor = 0.7

        let allCellObjectsList: [UIView] = [detailTitleLabel, detailDescriptionLabel, detailValueLabel]
        allCellObjectsList.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview($0)
        }
        self.selectionStyle = .none

        // MARK: - Cell content autolayout
        NSLayoutConstraint.activate([
            detailTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            detailTitleLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor),
            detailTitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.70),

            detailDescriptionLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            detailDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            detailDescriptionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.70),

            detailValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            detailValueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            detailValueLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3, constant: -6)
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
