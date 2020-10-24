import Foundation

class CoinRateCellViewModel: CoinRateCellRepresentable {
    var date: String
    var rate: String
    
    init(exchangeRate: ExchangeRate) {
        date = exchangeRate.date.formattedString()
        rate = "\(exchangeRate.rate) \(exchangeRate.currency)"
    }
    
}
