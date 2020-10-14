import UIKit

class CoinRatesTableViewController: UITableViewController {
    private var exchangeRates: [ExchangeRate] = []
    private let exchangeRatesCellID = "exchangeRat