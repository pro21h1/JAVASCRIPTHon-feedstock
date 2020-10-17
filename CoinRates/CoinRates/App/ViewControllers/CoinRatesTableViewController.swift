import UIKit

class CoinRatesTableViewController: UITableViewController {
    private var exchangeRates: [ExchangeRate] = []
    private let exchangeRatesCellID = "exchangeRatesCellID"
    private let exchangeRatesHandler: BitcoinRateHandler
    
    init(exchangeRatesHandler: BitcoinRateHandler) {
        self.exchangeRatesHandler = exchangeRatesHandler
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Bitcoint Exchange Rates"
        tableView.allowsSelection = false
        tableView.register(CoinRateTableViewCell.self, forCellReuseIdentifier: exchangeRatesCellID)
        
        updateTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableVie