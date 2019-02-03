import ObjectMapper

class Serializer {
    
    func mapModel<T: BaseMappable>(from json: Any) throws -> T {
        
        guard let object = Mapper<T>().map(JSONObject: json) else {
            throw MappingError.failedToMapValue
        }
        
        return object
    }
    
    func mapArrayWithForceCast<T: BaseMappable>(from json: Any) throws -> [T] {
        
        guard let array = Mapper<T>().mapArray(JSONObject: json) else {
            throw MappingError.failedToMapValue
        }
        
        return array
    }
    
}
