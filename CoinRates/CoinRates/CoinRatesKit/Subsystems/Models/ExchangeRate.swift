
import Foundation

public enum Currency: String {
    case EUR = "EUR"
    case UDL = "USD"
}

public struct ExchangeRate {
    let currency: Currency
    let rate: Double
    let date: Date
    
    init?(currency: Currency, json: Dictionary<String, Any>) {
        guard
            let dateString = json.keys.first,
            let rate = json.values.first as? Double
        else { return nil }
        self.currency = currency
        self.rate = rate
        guard let date = Date().formattedDate(from: dateString) else {
            return nil
        }
        self.date = date
    }
    
    init?(currentRateData: Dictionary<String, Any>) {
        
        guard
            let bpi = currentRateData["bpi"] as? JSON,
            let eur = bpi["EUR"] as? JSON,
            let time = currentRateData["time"] as? JSON,
            let isoDate = time["updatedISO"] as? String,
            let currency = eur["code"] as? String,
            let currencyCode = Currency(rawValue: currency),
            let rate = eur["rate_float"] as? Double,
            let date = Date.dateFromISOString(ISOString: isoDate)
        else { return nil }
        self.currency = currencyCode
        self.rate = rate
        self.date = date
    }
}