import WatchKit
import Foundation

class CoinRatesInterfaceController: WKInterfaceController {
    @IBOutlet var exchangeRatesTable: WKInterfaceTable!
    let controller: BitcoinRateHandler
    
    override init() {
        let connection: Connection = RemoteConnection()
        controller = BitcoinRateController(connection: connection, exchangeRateDataStore