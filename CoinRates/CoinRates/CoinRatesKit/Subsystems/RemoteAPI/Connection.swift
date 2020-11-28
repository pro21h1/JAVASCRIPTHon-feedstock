import Foundation

public typealias JSON = Dictionary<String, Any>

public enum Result<ValueType> {
    case success(ValueType)
    case failure(Error)
    
    public var value: ValueType? {
 