import ObjectMapper

struct BitcoinHistory: Mappable {
    
    var bpi = [String: Double]()
    var disclaimer = ""
    var time = BitcoinTime(JSONString: "")
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        bpi <- map["bpi"]
        disclaimer <- map["disclaimer"]
        time <- map["time"]
    }
    
    private func getDates(between startDate: Date, and endDate: Date) -> [String] {
        var dates = [String]()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-DD"
        var dateCounter = startDate
        while startDate <= endDate {
            if let date = Calendar.current.date(byAdding: .day, value: 1, to: dateCounter) {
                dates.append(formatter.string(from: date))
                dateCounter = date
            }
        }
        return dates
    }
    
}
