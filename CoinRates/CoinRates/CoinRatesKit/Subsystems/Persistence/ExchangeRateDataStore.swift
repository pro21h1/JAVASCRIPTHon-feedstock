import Foundation

protocol ExchangeRateDataStore {
    func addExchangeRates(exchangeRates: [ExchangeRate])
    func fetchExchangeRates() -> [ExchangeRate]
}
