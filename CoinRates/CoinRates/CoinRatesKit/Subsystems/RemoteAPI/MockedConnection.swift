import Foundation

// This could be user for testing or for those times when the backend guys are hard at work with their API

final class MockedConnection: Connection {
    private let historicalDataFileName: String
    private let currentDataFileName: String
    
    init(historicalDataFileName: String, currentDataFileName: String) {
        self.historicalDataFileName = historicalDataFileName
        self.currentDataFileName = currentDataFileName
    }
    
    func fetchHistoricalRate(forCurrency currency: Currency, from startDate: Date, to endDate: Date, completion: @escaping (Result<JSON>) -> ()) {
        do {
            guard let path = Bundle.main.path(forResource: historicalDataFileName, ofType: "json") else {
                throw CoinRatesError.InvalidPath
            }
            guard let data = NSData(contentsOfFile: path) else {
                throw CoinRatesError.NoData
            }
            guard let items = try JSONSerialization.jsonObject(with: data as Data, options: []) as? JSON else {
                throw CoinRatesError.JSONConversionFailed
            }
            guard let bpi = items["bpi"] as? JSON else {
                throw CoinRatesError.JSONConversionFailed
            }
            completion(.success(bpi))
        } catch let error as CoinRatesError {
            completion(.failure(error))
        } catch let error as NSError {
            completion(.failure(error))
        }
    }
    
    func fetchCurrentRate(forCurrency currency: Currency, completion: @escaping (Result<JSON>) -> ()) {
        do {
            guard let path = Bundle.main.path(forResource: currentDataFileName, ofType: "json") else {
                throw CoinRatesError.InvalidPath
            }
            guard let data = NSData(contentsOfFile: path) else {
                throw CoinRatesError.NoData
            }
            guard let items = try JSONSerialization.jsonObject(with: data as Data, options: []) as? JSON else {
                throw CoinRatesError.JSONConversionFailed
            }
            guard let bpi = items["bpi"] as? JSON else {
                throw CoinRatesError.JSONConversionFailed
            }
            guard let eur = bpi["EUR"] as? JSON else {
                throw CoinRatesError.JSONConversionFailed
            }
            completion(.success(eur))
        } catch let error as CoinRatesError {
            completion(.failure(error))
        } catch let error as NSError {
            completion(.failure(error))
        }
    }
}
