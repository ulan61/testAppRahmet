import ObjectMapper

struct BitcoinPriceWrapper: ImmutableMappable {
    
    let bpi: [String: Any]
    
    init(map: Map) throws {
        bpi = try map.value("bpi")
    }
    
    func getBitcoinPrice(for currency: String) -> BitcoinPrice? {
        return Mapper<BitcoinPrice>().map(JSONObject: bpi[currency])
    }
    
}

struct BitcoinPrice: ImmutableMappable {
    
    let code: String
    let rate: String
    let description: String
    let rateFloat: Double
    
    init(map: Map) throws {
        code = try map.value("code")
        rate = try map.value("rate")
        description = try map.value("description")
        rateFloat = try map.value("rate_float")
    }
    
}
