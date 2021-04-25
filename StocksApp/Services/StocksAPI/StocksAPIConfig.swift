//
//  StocksAPI.swift
//  StocksApp
//
//  Created by Alexey Koryakin on 29.03.2021.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var parameters: URLQueryItem { get }
    var token: URLQueryItem { get }
}

enum StocksAPI: Endpoint {
    case getQuote(ticker: String)
    case getCompanyProfile(ticker: String)

    var baseURL: String {
        switch self {
        default:
            return "finnhub.io"
        }
    }

    var path: String {
        switch self {
        case .getQuote:
            return "/api/v1/quote"
        case .getCompanyProfile:
            return "/api/v1/stock/profile2"
        }
    }

    var parameters: URLQueryItem {
        switch self {
        case .getQuote(let ticker), .getCompanyProfile(let ticker):
            return URLQueryItem(name: "symbol", value: ticker)
        }
    }

    var token: URLQueryItem {
        return URLQueryItem(name: "token", value: "c1h496n48v6t9ghtmhb0")
//        return URLQueryItem(name: "token", value: "sandbox_c1h496n48v6t9ghtmhbg")

    }
}
