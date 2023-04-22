import WatchKit

public class CoinRatesRowController: NSObject {
    @IBOutlet var dateLabel: WKInterfaceLabel!
    @IBOutlet var rateLabel: WKInterfaceLabel!
    
    var exchangeRate: ExchangeRate