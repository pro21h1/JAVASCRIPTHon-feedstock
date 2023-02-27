
import XCTest
import Foundation

@testable import CoinRates

class CoinRatesURLPathTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        let remoteConnection = RemoteConnection()
        let url = remoteConnection.bitcoinRatesURLWithComponents(currency: .EUR, from: Date(), to: Date().twoWeeksAgo())!
        XCTAssertNotNil(url)
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        XCTAssertNotNil(components?.queryItems)
        
        let queryItems = components!.queryItems!
        XCTAssertTrue(queryItems.count == 3)
        
        let expectedCurrencyQueryItem = URLQueryItem(name: "currency", value: "EUR")
        let expectedStartDateQueryItem = URLQueryItem(name: "start", value: Date().formattedString())
        let expectedEndDateQueryItem = URLQueryItem(name: "end", value: Date().twoWeeksAgo().formattedString())
        
        XCTAssertTrue(queryItems.contains(expectedCurrencyQueryItem))
        XCTAssertTrue(queryItems.contains(expectedStartDateQueryItem))
        XCTAssertTrue(queryItems.contains(expectedEndDateQueryItem))
    }
}