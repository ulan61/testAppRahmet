import ObjectMapper

struct BitcoinTime: ImmutableMappable {

    let updated: Date
    let updatedISO: Date
    
    init(map: Map) throws {
        updated = try map.value("updated")
        updatedISO = try map.value("updatedISO")
    }
    
}
