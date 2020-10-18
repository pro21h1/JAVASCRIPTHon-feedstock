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
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    // MARK: UITableView Delegate & DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchangeRates.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: exchangeRatesCellID) as! CoinRateTableViewCell
        cell.cellViewModel = CoinRateCellViewModel(exchangeRate: exchangeRates[inde