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
    
}
