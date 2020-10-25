import UIKit

extension CoinRateTableViewCell: CellConfigurable {
    // Associated type ViewModel -> EstateCellViewModel in our case
}

class CoinRateTableViewCell: UITableViewCell {
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 18)
        