//
//  UserDefaultsManagerTests.swift
//  StocksAppTests
//
//  Created by Alexey Koryakin on 05.04.2021.
//

import XCTest
@testable import StocksApp

class StockAPITests: XCTestCase {
    private var ticker: String!

    override func setUp() {
        super.setUp()
        ticker = "TSLA"
    }

    override func tearDown()  {
        ticker = nil
        super.tearDown()
    }

    func testForCreatingCorrectComponents() {
        // Arrange

        // Act
        let components = StockAPIWorker.createURLComponents(endpoint: StocksAPI.getQuote(ticker: ticker))

        // Assert
        let correctResult = URL(string: "https://finnhub.io/api/v1/quote?symbol=TSLA&token=c1h496n48v6t9ghtmhb0")
        XCTAssert(components.url == correctResult)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
