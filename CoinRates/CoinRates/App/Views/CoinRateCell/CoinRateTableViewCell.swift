import UIKit

extension CoinRateTableViewCell: CellConfigurable {
    // Associated type ViewModel -> EstateCellViewModel in our case
}

class CoinRateTableViewCell: UITableViewCell {
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 18)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rateLabel: UILabel = {
        let label = UILabel()
        label.font = UIF