import Foundation

protocol CoinRateCellRepresentable {
    var date: String { get }
    var rate: String { get }
}

protocol CellConfigurable: class {
    associatedtype CellViewModel
    var cellViewModel: CellViewModel? { get set }
}
