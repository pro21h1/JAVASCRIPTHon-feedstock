
import Foundation

final class MockedBitcoinRateController: BitcoinRateHandler {
    var exchangeRateDataStore: ExchangeRateDataStore
    
    init() {
        exchangeRateDataStore = ExchangeRateDataStoreDiskUserPrefs(currency: .EUR)
    }
    
    func fetchHistoricalRate(forCurrency currency: Currency, from startDate: Date, to endDate: Date, completion: @escaping (Result<[ExchangeRate]>) -> ()) {
        MockedConnection(historicalDataFileName: "data", currentDataFileName: "currentPriceData").fetchHistoricalRate(forCurrency: currency, from: startDate, to: endDate, completion: { result in
            switch result {
            case .success(let usersData):
                let exchangeRates = usersData.flatMap { ExchangeRate(currency: currency, json: [$0.key: $0.value]) }
                completion(.success(exchangeRates))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        })
    }
    
    func fetchCurrentRate(forCurrency currency: Currency, completion: @escaping (Result<ExchangeRate>) -> ()) {
        MockedConnection(historicalDataFileName: "data", currentDataFileName: "currentPriceData").fetchCurrentRate(forCurrency: currency, completion: { result in
            switch result {