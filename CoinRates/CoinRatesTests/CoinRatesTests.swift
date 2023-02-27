
import XCTest
@testable import CoinRates

class CoinRatesTests: XCTestCase {
    
    let connection: Connection = MockedConnection(historicalDataFileName: "data", currentDataFileName: "currentPriceData")
    let handler: BitcoinRateHandler = MockedBitcoinRateController()
    let startDate = Date()
    let endDate = Date().twoWeeksAgo()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFetchHistoricalRate() {
        connection.fetchHistoricalRate(forCurrency: .EUR, from: startDate, to: endDate, completion: { result in
            XCTAssertNotNil(result)
            XCTAssertNotNil(result.value)
            XCTAssertNil(result.error)
            XCTAssertTrue(result.value!.count > 0, "result must not be empty")
        })
    }
    
    func testFetchCurrentRate() {
        connection.fetchCurrentRate(forCurrency: .EUR, completion: { result in
            XCTAssertNotNil(result)
            XCTAssertNotNil(result.value)
            XCTAssertNil(result.error)
            XCTAssertTrue(result.value!.count > 0, "result must not be empty")
        })
    }
    
    func testHandlerForHistoricalData() {
        handler.fetchHistoricalRate(forCurrency: .EUR, from: startDate, to: endDate, completion: { exchangeRates in
            XCTAssertNotNil(exchangeRates)
            XCTAssertNotNil(exchangeRates.value!.first)
            XCTAssert(exchangeRates.value!.count == 14)
        })
    }
    
    func testHandlerForCurrentData() {
        handler.fetchCurrentRate(forCurrency: .EUR, completion: { exchangeRates in
            XCTAssertNotNil(exchangeRates)
            XCTAssertNotNil(exchangeRates.value)
            XCTAssertEqual(exchangeRates.value!.currency,Currency(rawValue: "EUR"))
        })
    }
    
    func testHandlerForAllData() {
        handler.fetchRatesForEUR(completion: { exchangeRates in
            DispatchQueue.main.async {
                XCTAssertNotNil(exchangeRates)
                XCTAssertNotNil(exchangeRates.value!.first)
                XCTAssertTrue(exchangeRates.value!.count == 15, "must be 15 elements in total")
            }
        })