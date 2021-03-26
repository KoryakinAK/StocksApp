//
//  StockModel.swift
//  StocksApp
//
//  Created by Alexey Koryakin on 20.03.2021.
//

import Foundation

struct Stock: Hashable, Codable {
    let ticker: String
    let name: String
    let currentPrice: Double
    let priceChange: Double
    let isFaved: Bool
}
