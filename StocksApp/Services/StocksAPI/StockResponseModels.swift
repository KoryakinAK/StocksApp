//
//  StockResponseModels.swift
//  StocksApp
//
//  Created by Alexey Koryakin on 30.03.2021.
//

import Foundation

struct Quote: Codable {
    let c: Float
    let h: Float
    let l: Float
    let o: Float
    let pc: Float
    let t: Float
}

struct CompanyProfile: Codable {
    let country: String
    let name: String
    let ticker: String
    let marketCapitalization: Float
    let finnhubIndustry: String
}

struct BasicFinancialsContainer: Codable {
    let metric: Metric
    let metricType: String
    let symbol: String
}

struct Metric: Codable {
    let the52WeekHigh: Double
    let the52WeekLow: Double
    let epsBasicExclExtraItemsAnnual: Double
    let marketCapitalization: Double
    let peBasicExclExtraTTM: Double?

    enum CodingKeys: String, CodingKey {
        case the52WeekHigh = "52WeekHigh"
        case the52WeekLow = "52WeekLow"
        case epsBasicExclExtraItemsAnnual = "epsBasicExclExtraItemsAnnual"
        case marketCapitalization = "marketCapitalization"
        case peBasicExclExtraTTM = "peBasicExclExtraTTM"
    }
}
