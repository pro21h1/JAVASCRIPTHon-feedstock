import Foundation

// This could be user for testing or for those times when the backend guys are hard at work with their API

final class MockedConnection: Connection {
    private let historicalDataFileName: String
    private let currentDataFileName: String
    
    init(historicalDataFileName: String, currentDataFileName: String) {
        se