import Foundation

class RemoteConnection: Connection {
    
    // MARK: Public Interfaces
    func fetchHistoricalRate(forCurrency currency: Currency, from startDate: Date, to endDate: Date, completion: @escaping (Result<JSON>) -> ()) {
        guard let historicalRatesURL = bitcoinRatesURLWithComponents(currency: currency, from: startDate, to: endDate) else {
            return completion(.failure(CoinRatesError.InvalidPath))
        }
        
        requestTask(with: URLRequest(url: historicalRatesURL), completion: { re