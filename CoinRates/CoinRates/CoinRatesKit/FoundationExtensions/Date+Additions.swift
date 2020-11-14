import Foundation

extension Date {
    
    func twoWeeksAgo() -> Date {
        return Calendar.current.date(byAdding: .day, value: -14, to: self)!
    }
    
    func formattedDate(from dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd