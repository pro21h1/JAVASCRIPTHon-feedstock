import Foundation

public typealias JSON = Dictionary<String, Any>

public enum Result<ValueType> {
    case success(ValueType)
    case failure(Error)
    
    public var value: ValueType? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
    
    public var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}

public enum CoinRatesError: Error {
    case NoHTTPResponse
    case HTTPError(statusCode: Int, errorDescription: String?)
    case NoData
    case JSONConversionFailed
    case InvalidPath
}

public enum URLPaths: String {
    case coindeskHistoricalRate = "https://api.coindesk.com/v1/bpi/historical/close.json"
    case coindeskCurrentRate = "https://api.coindesk.com/v1/bpi/currentprice/"
}

protocol Connection {
    func fetchHistoricalRate(forCurrency currency: Currency, from startDate: Date, to endDate: Date, completion: @escaping (Result<JSON>) -> ())
    func fetchCurrentRate(forCurrency currency: Currency, completion: @escaping (Result<JSON>) -> ())
}
