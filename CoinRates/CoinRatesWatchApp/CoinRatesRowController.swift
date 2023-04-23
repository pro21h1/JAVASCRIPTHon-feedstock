import WatchKit

public class CoinRatesRowController: NSObject {
    @IBOutlet var dateLabel: WKInterfaceLabel!
    @IBOutlet var rateLabel: WKInterfaceLabel!
    
    var exchangeRate: ExchangeRate? {
        didSet {
            if let rate = exchangeRate {
                dateLabel.setText(rate.date.formattedString())
                rateLabel.setText("\(rate.rate) \(rate.currency)")
            }
        }
    }
}
