
import Foundation

protocol BitcoinRateHandler {
    var exchangeRateDataStore: ExchangeRateDataStore { get }
    func fetchHistoricalRate(forCurrency currency: Currency, from startDate: Date, to endDate: Date, completion: @escaping (Result<[ExchangeRate]>) -> ())
    func fetchCurrentRate(forCurrency currency: Currency, completion: @escaping (Result<ExchangeRate>) -> ())
    func fetchRatesForEUR(completion: @escaping (Result<[ExchangeRate]>) -> ())
}