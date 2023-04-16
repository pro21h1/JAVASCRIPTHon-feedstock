import WatchKit
import Foundation

class CoinRatesInterfaceController: WKInterfaceController {
    @IBOutlet var exchangeRatesTable: WKInterfaceTable!
    let controller: BitcoinRateHandler
    
    override init() {
        let 