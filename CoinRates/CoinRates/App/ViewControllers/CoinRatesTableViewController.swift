import UIKit

class CoinRatesTableViewController: UITableViewController {
    private var exchangeRates: [ExchangeRate] = []
    private let exchangeRatesCellID = "exchangeRatesCellID"
    private let exchangeRatesHandler: BitcoinRateHandler
    
    init(exchangeRatesHandler: BitcoinRateHandler) {
      