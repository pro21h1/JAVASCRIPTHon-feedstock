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
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var cellViewModel: CoinRateCellViewModel? {
        didSet {
            guard let cellViewModel = cellViewModel else { return }
            dateLabel.text = cellViewModel.date
            rateLabel.text = cellViewModel.rate
        }
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(dateLabel)
        addSubview(rateLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: layoutMargins.left),
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -layoutMargins.right),
            
            rateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: layoutMargins.left),
            rateLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            rateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -layoutMargins.right),
            rateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
            ])
    }
}
