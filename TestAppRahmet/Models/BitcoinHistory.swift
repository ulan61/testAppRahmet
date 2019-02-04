import ObjectMapper

struct BitcoinHistory: ImmutableMappable {
    
    let bpi: [String: Double]
    let disclaimer: String
    let time: BitcoinTime
    
    init(map: Map) throws {
        bpi = try map.value("bpi")
        disclaimer = try map.value("disclaimer")
        time = try map.value("time")
    }
    
}
