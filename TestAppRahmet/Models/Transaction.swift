import ObjectMapper

struct Transaction: ImmutableMappable {

    let date: Date
    let tid: String
    let price: String
    let type: String
    let amount: String
    
    init(map: Map) throws {
        date = try map.value("date", using: DateTransform())
        tid = try map.value("tid")
        price = try map.value("price")
        type = try map.value("type")
        amount = try map.value("amount")
    }
        
}
