import Foundation

extension Date {
    
    func twoWeeksAgo() -> Date {
        return Calendar.current.date(byAdding: .day, value: -14, to: self)!
    }
    
    func formattedDate(from dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.date(from:dateString)
    }
    
    func formattedString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from:self)
    }
    
    static func dateFromISOString(ISOString: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter.date(from: ISOString)
    }
}
