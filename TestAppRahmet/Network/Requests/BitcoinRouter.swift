import Alamofire

enum BitcoinRouter: BaseRouter {
    
    case getHistory(currencyCode: String, startDate: Date, endDate: Date)
    case getCurrentPrice(currency: String)

    var baseApiUrl: String {
        return bitcoinUrl + "/v1/bpi"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters? {
        switch self {
        case .getCurrentPrice:
            return nil
        case .getHistory(let currencyCode, let startDate, let endDate):
            return ["currency": currencyCode,
                    "start": startDate.toString(with: "YYYY-MM-dd"),
                    "end": endDate.toString(with: "yyyy-MM-dd")]
        }
    }
    
    var path: String {
        switch self {
        case .getCurrentPrice(let currency):
            return "/currentprice/\(currency).json"
        case .getHistory:
            return "/historical/close.json"
        }
    }
    
}
