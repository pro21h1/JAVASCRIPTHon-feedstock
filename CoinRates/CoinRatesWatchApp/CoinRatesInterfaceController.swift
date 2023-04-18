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
            Dispat