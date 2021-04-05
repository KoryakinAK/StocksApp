//
//  FormatterConfiguration.swift
//  StocksApp
//
//  Created by Alexey Koryakin on 03.04.2021.
//

import Foundation

class StockDataFormatter: NumberFormatter {
    private static let instance = StockDataFormatter()

    class func priceChangeFormatter() -> StockDataFormatter {
        instance.minimumFractionDigits = 2
        instance.maximumFractionDigits = 2
        instance.numberStyle = .percent
        instance.decimalSeparator = "."
        return instance
    }

    class func priceFormatter() -> StockDataFormatter {
        instance.minimumFractionDigits = 2
        instance.maximumFractionDigits = 2
        instance.numberStyle = .decimal
        instance.decimalSeparator = "."
        return instance
    }
}
