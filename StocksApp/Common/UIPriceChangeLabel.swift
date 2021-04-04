//
//  UIPriceChangeLabel.swift
//  StocksApp
//
//  Created by Alexey Koryakin on 02.04.2021.
//

import UIKit

class UIPriceChangeLabel: UILabel {

    override var text: String? {
        willSet {
            guard
                let newValue = newValue,
                let priceChange = PriceChangeFormatter.sharedInstance().number(from: newValue)
            else {
                return
            }
            if priceChange.decimalValue >= 0 {
                self.textColor = .systemGreen
            } else {
                self.textColor = .systemRed
            }
        }
    }
}
