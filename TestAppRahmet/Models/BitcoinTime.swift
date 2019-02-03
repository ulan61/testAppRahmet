import ObjectMapper

struct BitcoinTime: Mappable {
    
    var updated: Date = Date()
    var updatedISO: Date = Date()
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        updated <- map["updated"]
        updatedISO <- map["updatedISO"]
    }
    
}
