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
    let currentPrice: Float
    let openPrice: Float
    let country: String
    let marketCapitalization: Float
    let finnhubIndustry: String
    let the52WeekHigh: Double
    let the52WeekLow: Double
    let epsBasicExclExtraItemsAnnual: Double
    let peBasicExclExtraTTM: Double?

    internal init(ticker: String, name: String, currentPrice: Float, openPrice: Float, country: String, marketCapitalization: Float, finnhubIndustry: String, the52WeekHigh: Double, the52WeekLow: Double, epsBasicExclExtraItemsAnnual: Double, peBasicExclExtraTTM: Double?) {
        self.ticker = ticker
        self.name = name
        self.currentPrice = currentPrice
        self.openPrice = openPrice
        self.country = country
        self.marketCapitalization = marketCapitalization
        self.finnhubIndustry = finnhubIndustry
        self.the52WeekHigh = the52WeekHigh
        self.the52WeekLow = the52WeekLow
        self.epsBasicExclExtraItemsAnnual = epsBasicExclExtraItemsAnnual
        self.peBasicExclExtraTTM = peBasicExclExtraTTM
    }

    init() {
        self.ticker = ""
        self.name = ""
        self.currentPrice = 0.0
        self.openPrice = 0.0
        self.country = ""
        self.marketCapitalization = 0.0
        self.finnhubIndustry = ""
        self.the52WeekHigh = 0.0
        self.the52WeekLow = 0.0
        self.epsBasicExclExtraItemsAnnual = 0.0
        self.peBasicExclExtraTTM = 0.0
    }

    init(quote: Quote, companyProfile: CompanyProfile, metrics: Metric) {
        self.ticker = companyProfile.ticker
        self.name = companyProfile.name
        self.currentPrice = quote.c
        self.openPrice = quote.o
        self.country = companyProfile.country
        self.marketCapitalization = companyProfile.marketCapitalization
        self.finnhubIndustry = companyProfile.finnhubIndustry
        self.the52WeekHigh = metrics.the52WeekHigh
        self.the52WeekLow = metrics.the52WeekLow
        self.epsBasicExclExtraItemsAnnual = metrics.epsBasicExclExtraItemsAnnual
        self.peBasicExclExtraTTM = metrics.peBasicExclExtraTTM ?? 0.0
    }
}
