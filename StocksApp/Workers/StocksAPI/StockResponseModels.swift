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
