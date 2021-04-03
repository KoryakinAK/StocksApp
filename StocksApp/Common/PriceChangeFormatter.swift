//
//  FormatterConfiguration.swift
//  StocksApp
//
//  Created by Alexey Koryakin on 03.04.2021.
//

import Foundation

class PriceChangeFormatter: NumberFormatter {
    private static let instance = PriceChangeFormatter()

    class func sharedInstance() -> PriceChangeFormatter {
        instance.minimumFractionDigits = 2
        instance.maximumFractionDigits = 2
        instance.numberStyle = .percent
        instance.decimalSeparator = "."
        return instance
    }
}
