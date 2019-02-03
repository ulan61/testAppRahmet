import Alamofire

enum BitcoinRouter: BaseRouter {
    
    case getHistory(startDate: Date, endDate: Date)

    var baseApiUrl: String {
        return bitcoinUrl
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return ""
    }
    
}
