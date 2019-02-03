import Alamofire

enum TransactionRouter: BaseRouter {
  
    case getTransactions
    
    var baseApiUrl: String {
        return transactionsUrl + "/api/v2"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/transactions/btcusd/"
    }
    
}
