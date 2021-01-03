import Foundation

class RemoteConnection: Connection {
    
    // MARK: Public Interfaces
    func fetchHistoricalRate(forCurrency currency: Currency, from startDate: Date, to end