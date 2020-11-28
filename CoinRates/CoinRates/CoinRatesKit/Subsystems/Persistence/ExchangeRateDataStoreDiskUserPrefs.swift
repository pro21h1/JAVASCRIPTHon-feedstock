import Foundation

public class ExchangeRateDataStoreDiskUserPrefs: ExchangeRateDataStore {
    let currency: Currency
    
    init(currency: Currency) {
        self.currency = currency
    }
    
    func addExchangeRates(exchangeRates: [ExchangeRate]) {
        let dictionaries = exchangeRates.map { exchangeRate in
            return [exchangeRate.date.formattedString(): exchangeRate.rate]
        }
        
        UserDefaults.standard.set(dictionaries, forKey: "exchangeRates")
        UserDefaults.standard.synchronize()
    }
    
    func fetchExchangeRates() -> [ExchangeRate] {
        guard let dictionaries = UserDefaults.standard.array(forKey: "exchangeRat