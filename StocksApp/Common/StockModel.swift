//
//  StockModel.swift
//  StocksApp
//
//  Created by Alexey Koryakin on 20.03.2021.
//

import Foundation

struct Stock: Hashable, Codable {

    internal init(ticker: String, name: String, currentPrice: Float, priceChange: Float, isFaved: Bool, country: String, marketCapitalization: Float, finnhubIndustry: String) {
        self.ticker = ticker
        self.name = name
        self.currentPrice = currentPrice
        self.openPrice = priceChange
        self.isFaved = isFaved
        self.country = country
        self.marketCapitalization = marketCapitalization
        self.finnhubIndustry = finnhubIndustry
    }

    let ticker: String
    let name: String
    let currentPrice: Float
    let openPrice: Float
    var isFaved: Bool
    let country: String
    let marketCapitalization: Float
    let finnhubIndustry: String

    init(quote: Quote, companyProfile: CompanyProfile) {
        self.ticker = companyProfile.ticker
        self.name = companyProfile.name
        self.currentPrice = quote.c
        self.openPrice = quote.o
        self.country = companyProfile.country
        self.marketCapitalization = companyProfile.marketCapitalization
        self.finnhubIndustry = companyProfile.finnhubIndustry
        self.isFaved = false
    }
}
