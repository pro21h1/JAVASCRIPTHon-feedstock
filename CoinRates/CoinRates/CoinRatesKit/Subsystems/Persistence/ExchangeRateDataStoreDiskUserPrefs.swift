import Foundation

public class ExchangeRateDataStoreDiskUserPrefs: ExchangeRateDataStore {
    let currency: Currency
    
    init(currency: Currency) {
        self.currency = currency
    }
    
    func addExchangeRates(exchangeRates: [ExchangeRate]) {
        let dictionaries = exchangeRates.map { exchangeRate in
            return [exc