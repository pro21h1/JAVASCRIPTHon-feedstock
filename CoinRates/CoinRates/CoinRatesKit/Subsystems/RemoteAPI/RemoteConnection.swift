import Foundation

class RemoteConnection: Connection {
    
    // MARK: Public Interfaces
    func fetchHistoricalRate(forCurrency currency: Currency, from startDate: Date, to endDate: Date, completion: @escaping (Result<JSON>) -> ()) {
        guard let historicalRatesURL = bitcoinRatesURLWithComponents(currency: currency, from: startDate, to: endDate) else {
            return completion(.failure(CoinRatesError.InvalidPath))
        }
        
        requestTask(with: URLRequest(url: historicalRatesURL), completion: { result, response in
            switch result {
            case .success(let data):
                do {
                    guard let items = try JSONSerialization.jsonObject(with: data, options: []) as? JSON else {
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
            case .failure(let error):
                completion(.failure(error))
            }
        }).resume()
    }
    
    func fetchCurrentRate(forCurrency currency: Currency, completion: @escaping (Result<JSON>) -> ()) {
        guard let currentRateURL = URL(string: URLPaths.coindeskCurrentRate.rawValue + "\(currency).json") else {
            return completion(.failure(CoinRatesError.InvalidPath))
        }
        
        requestTask(with: URLRequest(url: currentRateURL), completion: { result, response in
            switch result {
            case .success(let data):
                do {
                    guard let items = try JSONSerialization.jsonObject(with: data, options: []) as? JSON else {
                        throw CoinRatesError.JSONConversionFailed
                    }
                    completion(.success(items))
                } catch let error as CoinRatesError {
                    completion(.failure(error))
                } catch let error as NSError {
                    completion(.failure(error))
                }
            case .failure(let err