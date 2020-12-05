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
   