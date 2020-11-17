
import Foundation

final class BitcoinRateController: BitcoinRateHandler {
    let connection: Connection
    var exchangeRateDataStore: ExchangeRateDataStore
    
    init(connection: Connection, exchangeRateDataStore: ExchangeRateDataStore) {
        self.connection = connection
        self.exchangeRateDataStore = exchangeRateDataStore
    }
    
    func fetchHistoricalRate(forCurrency currency: Currency, from startDate: Date, to endDate: Date, completion: @escaping (Result<[ExchangeRate]>) -> ()) {
        connection.fetchHistoricalRate(forCurrency: currency, from: startDate, to: endDate) { result in
            switch result {
            case .success(let exchangeRateData):
                let exchangeRates = exchangeRateData.flatMap { ExchangeRate(currency: .EUR, json: [$0.key: $0.value]) }
                completion(.success(exchangeRates))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    func fetchCurrentRate(forCurrency currency: Currency, completion: @escaping (Result<ExchangeRate>) -> ()) {
        connection.fetchCurrentRate(forCurrency: currency, completion: { result in
            switch result {
            case .success(let exchangeRateData):
                guard let currentExchangeRate = ExchangeRate(currentRateData: exchangeRateData) else {
                    return
                }
                completion(.success(currentExchangeRate))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        })
    }
    
    func fetchRatesForEUR(completion: @escaping (Result<[ExchangeRate]>) -> ()) {
        // Retrieve first local cached data
        completion(.success(exchangeRateDataStore.fetchExchangeRates()))
        fetchHistoricalRate(forCurrency: .EUR, from: Date().twoWeeksAgo(), to: Date()) {[weak self]  historicalResult in
            switch historicalResult {
            case .success(let historicalExchangeRates):
                self?.fetchCurrentRate(forCurrency: .EUR, completion: { currentResult in
                    switch currentResult {
                    case .success(let currentExchangeRate):
                        
                        var allRates = historicalExchangeRates
                        allRates.append(currentExchangeRate)
                        
                        let sortedExchangeRates = allRates.sorted{$0.date > $1.date}
                        self?.exchangeRateDataStore.addExchangeRates(exchangeRates: sortedExchangeRates)
                        
                        // Retrieve latest data
                        completion(.success(sortedExchangeRates))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                })
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}