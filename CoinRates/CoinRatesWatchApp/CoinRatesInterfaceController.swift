import WatchKit
import Foundation

class CoinRatesInterfaceController: WKInterfaceController {
    @IBOutlet var exchangeRatesTable: WKInterfaceTable!
    let controller: BitcoinRateHandler
    
    override init() {
        let connection: Connection = RemoteConnection()
        controller = BitcoinRateController(connection: connection, exchangeRateDataStore: ExchangeRateDataStoreDiskUserPrefs(currency: .EUR))
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        controller.fetchRatesForEUR() { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let exchangeRates):
                    self.exchangeRatesTable.setNumberOfRows(exchangeRates.count, withRowType: "ExchangeRow")
                    for index in 0..<self.exc