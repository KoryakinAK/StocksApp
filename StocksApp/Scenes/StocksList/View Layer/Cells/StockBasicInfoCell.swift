//
//  StockBasicInfoCell.swift
//  StocksApp
//
//  Created by Alexey Koryakin on 25.04.2021.
//

import UIKit

enum BasicInfoCellContentType: String {
    case country = "Страна"
    case industry = "Область"
    case other = "Другое"
}

class StockBasicInfoCell: UICollectionViewCell {

    static var reuseIdentifier: String = "StockBasicInfoCell"

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = .secondaryLabel

        return label
    }()

    let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .label
        return label
    }()

    func configure(with stock: Stock, for type: BasicInfoCellContentType) {
        switch type {
        case .country:
            titleLabel.text = type.rawValue
            valueLabel.text = stock.country
        case .industry:
            titleLabel.text = type.rawValue
            valueLabel.text = stock.finnhubIndustry
        case .other:
            titleLabel.text = type.rawValue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 12.0
        self.backgroundColor = .white

        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
        NSLayoutConstraint.activate([
            valueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),

            titleLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
